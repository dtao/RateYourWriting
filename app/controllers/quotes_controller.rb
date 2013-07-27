class QuotesController < ApplicationController
  before_filter :require_admin, :only => [:index]

  def index
    @quotes = Quote.all
  end
end
