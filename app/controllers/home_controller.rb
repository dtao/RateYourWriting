class HomeController < ApplicationController
  def index
  end

  def login
    if request.post?
      user = User.find_by_email(params[:email])

      if user.nil?
        alert 'That user does not exist.', :warning
        return redirect_to :action => 'login'
      end

      if !user.authenticate(params[:password])
        alert 'That is not the right password.', :warning
        return redirect_to :action => 'login'
      end

      alert "Welcome back, #{user.name}!", :success
      login_user(user)
    end
  end

  def register
  end

  def logout
    session.delete(:user_id)
    alert 'Successfully logged out.', :success
    redirect_to :controller => 'home', :action => 'index'
  end
end
