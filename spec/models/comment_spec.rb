require 'spec_helper'

describe Comment do
  it 'disallows comments with blank content' do
    lambda { users(:jack).comment!(submissions("Jill's Story"), '') }.should raise_error
  end
end
