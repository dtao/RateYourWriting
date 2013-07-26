require 'spec_helper'

describe Vote do
  let(:attributes) {
    {
      :user => users(:jack),
      :submission => submissions("Jack's Story"),
      :rating => 8
    }
  }

  it 'requires a user' do
    lambda { Vote.create!(attributes.except(:user)) }.should raise_error
  end

  it 'requires a submission' do
    lambda { Vote.create!(attributes.except(:submission)) }.should raise_error
  end

  it 'requires a rating' do
    lambda { Vote.create!(attributes.except(:rating)) }.should raise_error
  end

  it 'disallows ratings below 1' do
    lambda { Vote.create!(attributes.merge(:rating => 0)) }.should raise_error
  end

  it 'disallows ratings above 10' do
    lambda { Vote.create!(attributes.merge(:rating => 11)) }.should raise_error
  end

  it 'prevents duplicate votes' do
    users(:jack).vote!(submissions("Jill's Story"), 8)
    lambda { users(:jack).vote!(submissions("Jill's Story"), 8) }.should raise_error
  end

  it 'prevents a user from voting for his/her own submission' do
    lambda { users(:jack).vote!(submissions("Jack's Story"), 10) }.should raise_error
  end
end
