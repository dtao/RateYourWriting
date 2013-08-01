require 'looks_like'

class HomeController < ApplicationController
  force_ssl :host => Env::HTTPS_HOST, :only => [:login, :register], :unless => lambda { Rails.env.development? }

  def index
    @daily_news = NewsItem.daily.latest.all(:include => 'user')
    @site_news = NewsItem.site.latest.all(:include => 'user')
  end

  def login
    if request.post?
      user = nil

      if LooksLike.email?(params[:name_or_email])
        user = User.find_by_email(params[:name_or_email])
      end

      user ||= User.find_by_name(params[:name_or_email])

      if user.nil?
        alert 'That user does not exist.', :warning
        return redirect_to :action => 'login'
      end

      if !user.authenticate(params[:password])
        alert 'That is not the right password.', :warning
        return redirect_to :action => 'login'
      end

      login_user(user)
    end
  end

  def login_with_token
    token = SingleUseLogin.find_by_token(params[:token])
    user = token.use_and_destroy!
    session[:user_id] = user.id
    alert "Welcome #{user.last_login ? 'back' : 'to RateYourWriting'}, #{user.name}!", :success
    redirect_to root_path
  end

  def register
  end

  def logout
    session.delete(:user_id)
    alert 'Successfully logged out.', :success
    redirect_to root_path
  end

  def about
  end

  def markdown_help
  end

  def settings
    @preferences = current_user.preferences || UserPreferences.create!({
      :user => current_user,
      :theme => UserPreferences::DEFAULT_THEME
    })
  end
end
