class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_theme, :set_unread_message_count

  rescue_from ActiveRecord::ActiveRecordError, :with => :handle_exception

  helper_method :current_user, :logged_in?, :is_new_for_user?

  def alert(message, type=:info)
    flash[:notice] = {
      :message => message,
      :type => type
    }
  end

  def login_user(user)
    if user.email_verified?
      session[:user_id] = user.id
      user.update_attributes({
        :previous_login => user.last_login,
        :last_login => Time.now.utc
      })

    else
      alert 'You must verify your e-mail address.', :error
    end

    # No need to serve every page henceforth over HTTPS!
    redirect_to root_url(:protocol => 'http')
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

  def handle_exception(exception)
    alert exception.message, :error
    redirect_to request.referrer || root_path
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
      @unread_message_count = current_user.messages.where(['created_at > ?', current_user.previous_login]).count
    else
      @unread_message_count = 0
    end
  end
end
