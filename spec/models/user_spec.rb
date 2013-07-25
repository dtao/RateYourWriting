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

  describe '#vote_for' do
    it 'finds the vote a user placed for a submission' do
      jack = users(:jack)
      jills_story = submissions("Jill's Story")

      jack.vote_for(jills_story).should be_nil
      jack.vote!(jills_story, 8)

      vote = jack.vote_for(jills_story)
      vote.user.should == jack
      vote.submission.should == jills_story
      vote.rating.should == 8
    end
  end
end
