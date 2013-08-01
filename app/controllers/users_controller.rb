class UsersController < ApplicationController
  before_filter :require_admin, :only => [:index]

  def index
    @users = User.order(:name => :asc).limit(25)
  end

  def show
    @user = User.find(params[:id])
    @submissions = @user.submissions.order(:id => :desc)
    @submissions = @submissions.published unless @user == current_user
  end

  def create
    User.transaction do
      user = User.create!(user_params)
      UserMailer.email_verification(user).deliver
      alert "Check your e-mail, #{user.name}!", :success
      redirect_to root_url(Env.url_options('http'))
    end
  end

  def update
    user = User.find(params[:id])

    if user != current_user
      alert "You cannot change another user's settings!"
      return redirect_to root_path
    end

    user.update_attributes(user_params)
    alert 'Updated settings!', :success
    redirect_to root_path
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

  def preferences
    preferences = current_user.preferences
    current_user.preferences.update_attributes(preferences_params)
    session[:theme] = params[:preferences][:theme]
    alert 'Updated preferences!', :success
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :website, :bio)
  end

  def preferences_params
    return params.require(:preferences).permit(:theme)
  end
end
