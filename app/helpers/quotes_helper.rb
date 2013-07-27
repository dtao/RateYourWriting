module QuotesHelper
  def random_quote
    @quote = Quote.find_by_id(1 + rand(Quote.count))
    return '' if @quote.nil?
    render(:partial => 'quotes/quote')
  end
end
