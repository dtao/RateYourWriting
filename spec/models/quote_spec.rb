require 'spec_helper'

describe Quote do
  let(:attributes) {
    {
      :user => users(:jack),
      :content => "Life is like a box of chocolates: you never know what you're gonna get.",
      :source => 'Mrs. Gump'
    }
  }

  it 'requires a user' do
    lambda { Quote.create!(attributes.except(:user)) }.should raise_error
  end
end
