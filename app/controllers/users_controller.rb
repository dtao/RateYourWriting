class UsersController < ApplicationController
  def create
    user = User.create!(user_params)
    alert "Registered user with e-mail address #{user.email}!", :success
    redirect_to :controller => 'home', :action => 'index'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
