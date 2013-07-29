class HomeController < ApplicationController
  force_ssl :if => lambda { Rails.env.production? }, :only => [:login, :register]

  def index
    @daily_news = NewsItem.daily.latest
    @site_news = NewsItem.site.latest
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
    redirect_to root_path
  end

  def preferences
    @preferences = current_user.preferences || UserPreferences.create!({
      :user => current_user,
      :theme => UserPreferences::DEFAULT_THEME
    })

    if request.post? || request.patch?
      @preferences.update_attributes(preferences_params)
      session[:theme] = params[:preferences][:theme]
      alert 'Updated preferences!', :success
      redirect_to root_path
    end
  end

  private

  def preferences_params
    return params.require(:preferences).permit(:theme)
  end
end
