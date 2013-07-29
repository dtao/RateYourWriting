class QuotesController < ApplicationController
  before_filter :require_admin

  def index
    @quotes = Quote.all
  end

  def new
    @quote = Quote.new
  end

  def create
    quote = Quote.create!(quote_params)
    alert 'Created new quote!', :success
    redirect_to quotes_path
  end

  private

  def quote_params
    params.require(:quote).permit(:content, :source).merge(:user => current_user)
  end
end
