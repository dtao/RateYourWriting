class UsersController < ApplicationController
  def create
    user = User.create!(user_params)
    alert "Welcome to RateYourWriting, #{user.name}!", :success
    return login_user(user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
