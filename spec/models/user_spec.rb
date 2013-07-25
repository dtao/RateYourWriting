require 'spec_helper'

describe User do
  let(:attributes) {
    {
      :name => 'Dan',
      :email => 'daniel.tao@gmail.com',
      :password => 'passw0rd',
      :password_confirmation => 'passw0rd'
    }
  }

  it 'requires a name' do
    lambda { User.create!(attributes.except(:name)) }.should raise_error
  end

  it 'prohibits blank names' do
    lambda { User.create!(attributes.merge(:name => '')) }.should raise_error
  end

  it 'does not require name to be unique' do
    lambda {
      User.create!(attributes)
      User.create!(attributes.merge(:email => 'daniel.tao@yahoo.com'))
    }.should change(User, :count).by(2)
  end

  it 'requires an e-mail address' do
    lambda { User.create!(attributes.except(:email)) }.should raise_error
  end

  it 'prohibits blank e-mail addresses' do
    lambda { User.create!(attributes.merge(:email => '')) }.should raise_error
  end

  it 'requires e-mail address to be unique' do
    User.create!(attributes)
    lambda { User.create!(attributes) }.should raise_error
  end
end
