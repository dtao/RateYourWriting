require 'looks_like'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_theme, :set_unread_message_count, :set_message

  rescue_from ActiveRecord::ActiveRecordError, :with => :handle_exception

  helper_method :current_user, :logged_in?, :is_new_for_user?

  def alert(message, type=:info)
    if request.env['HTTP_HOST'] == Env::HTTP_HOST
      alert_with_flash(message, type)

    else
      @notice = SingleUseNotice.create!({
        :user => current_user,
        :message => message,
        :notice_type => type
      })
    end
  end

  def alert_with_flash(message, type=:info)
    flash[:notice] = {
      :message => message,
      :type => type
    }
  end

  def find_user(params)
    user = nil

    if LooksLike.email?(params[:name_or_email])
      user = User.find_by_email(params[:name_or_email])
    end

    user || User.find_by_name(params[:name_or_email])
  end

  def require_admin
    unless logged_in? && current_user.admin?
      alert 'Only admins are allowed to access that section!', :warning
      redirect_to root_path
    end
  end

  def current_user
    # Check a flag instead of @current_user directly since otherwise if the user is not logged in
    # we'll keep querying the DB every time this method is called.
    if !@current_user_cached
      @current_user = User.find_by_id(session[:user_id])
      @current_user_cached = true
    end

    @current_user
  end

  def logged_in?
    current_user && current_user.email_verified?
  end

  def is_new_for_user?(time)
    time.present? && logged_in? && current_user.previous_login.present? &&
      time > current_user.previous_login
  end

  def set_theme
    possible_themes = UserPreferences::THEMES

    # 1. Always allow a query flag to force a given theme
    # 2. If the user is logged in, use his/her preferred theme
    # 3. Otherwise, see if any theme has been stored in the current session (i.e., if the user
    #    logged out, continue to use the theme he/she was using)
    # 4. Lastly, fall back to the default

    if params.include?(:theme) && possible_themes.include?(params[:theme])
      @theme = params[:theme]

    elsif logged_in? && current_user.preferences
      @theme = current_user.preferences.theme

    elsif session[:theme] && possible_themes.include?(session[:theme])
      @theme = session[:theme]

    else
      @theme = UserPreferences::DEFAULT_THEME
    end
  end

  def set_unread_message_count
    if logged_in?
      if current_user.previous_login.nil?
        @unread_message_count = current_user.messages.count
      else
        @unread_message_count = current_user.messages.where(['created_at > ?', current_user.previous_login]).count
      end
    end
    @unread_message_count = nil if @unread_message_count == 0
  end

  def set_message
    if params.include?(:notice)
      notice = SingleUseNotice.find_by_token(params.delete(:notice))
      if notice
        message, type = notice.use_and_destroy!
        alert_with_flash message, *type
        redirect_to request.path, params
      end
    end
  end

  def default_url_options
    if @notice.nil?
      {}
    else
      { :notice => @notice.token }
    end
  end

  def handle_exception(exception)
    case exception
    when ActiveRecord::RecordInvalid
      # TODO: Format record validation errors more nicely.
      alert exception.message, :error
    else
      alert exception.message, :error
    end

    redirect_to request.referrer || root_path
  end
end
