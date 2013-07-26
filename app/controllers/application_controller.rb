class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_theme

  rescue_from ActiveRecord::RecordInvalid, :with => :handle_exception

  helper_method :current_user, :logged_in?, :is_new_for_user?

  def alert(message, type=:info)
    flash[:notice] = {
      :message => message,
      :type => type
    }
  end

  def login_user(user)
    session[:user_id] = user.id
    user.update_attributes(:last_login => Time.now.utc)
    redirect_to root_path
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
    !!current_user
  end

  def is_new_for_user?(time, user=nil)
    user ||= current_user
    time.present? && logged_in? && current_user.last_login &&
      time > (current_user.last_login - 5.minutes)
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
end
