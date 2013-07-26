module NewsItemsHelper
  def render_news_item(news_item)
    render(:partial => 'news_items/news_item', :locals => { :item => news_item })
  end
end
