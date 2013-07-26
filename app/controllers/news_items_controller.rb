class NewsItemsController < ApplicationController
  def new
    @news_item = NewsItem.new
  end

  def create
    news_item = NewsItem.create!(news_item_params)
    alert "Created news item '#{news_item.headline}'!", :success
    redirect_to root_path
  end

  private

  def news_item_params
    params.require(:news_item).permit(:kind, :headline, :content).merge(:user => current_user)
  end
end
