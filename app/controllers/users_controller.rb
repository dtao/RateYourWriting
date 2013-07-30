class UsersController < ApplicationController
  before_filter :require_admin, :only => [:index]

  def index
    @users = User.order(:name => :asc).limit(25)
  end

  def show
    @user = User.find(params[:id])
    @submissions = @user.submissions.all(:order => 'id desc')
  end

  def create
    User.transaction do
      user = User.create!(user_params)
      UserMailer.email_verification(user).deliver
      alert "Check your e-mail, #{user.name}!", :success
      redirect_to root_url(:protocol => 'http', :host => Env::HTTP_HOST)
    end
  end

  def verify
    user = User.find(params[:id])
    token = VerificationToken.find_by_token(params[:token])
    if token.user_id == user.id
      user.update_attributes(:email_verified => true)
    end

    alert "Welcome to RateYourWriting, #{user.name}!", :success
    return login_user(user)
  end

  def message
    @user = User.find(params[:id])
    @message = Message.new(:recipient => @user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
