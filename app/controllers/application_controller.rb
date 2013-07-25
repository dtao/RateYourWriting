class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def alert(message, type=:info)
    flash[:notice] = {
      :message => message,
      :type => type
    }
  end

end
