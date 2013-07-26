class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordInvalid, :with => :handle_exception

  helper_method :current_user, :logged_in?

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

  def handle_exception(exception)
    alert exception.message, :error
    redirect_to request.referrer || root_path
  end
end
