class HomeController < ApplicationController
  def index
    @daily_news = NewsItem.daily.latest.all(:include => 'user')
    @site_news = NewsItem.site.latest.all(:include => 'user')
  end

  def logout
    session.delete(:user_id)
    alert 'Successfully logged out.', :success
    redirect_to root_path
  end

  def settings
    @preferences = current_user.preferences || UserPreferences.create!({
      :user => current_user,
      :theme => UserPreferences::DEFAULT_THEME
    })
  end
end
