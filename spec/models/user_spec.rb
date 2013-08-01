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

  it 'requires an e-mail address' do
    lambda { User.create!(attributes.except(:email)) }.should raise_error
  end

  it 'prohibits blank e-mail addresses' do
    lambda { User.create!(attributes.merge(:email => '')) }.should raise_error
  end

  it 'requires name to be unique' do
    User.create!(attributes)
    lambda { User.create!(attributes.merge(:email => 'adam.tao@gmail.com')) }.should raise_error
  end

  it 'requires e-mail address to be unique' do
    User.create!(attributes)
    lambda { User.create!(attributes.merge(:name => 'Adam')) }.should raise_error
  end

  it 'does not allow "@" characters in names' do
    lambda { User.create!(attributes.merge(:name => 'Dan@')) }.should raise_error
  end

  it 'maintains a counter cache for submission count' do
    jack = users(:jack)
    lambda {
      jack.submissions.create!({
        :kind => 'B',
        :title => "Jack's Book Chapter 1",
        :body => 'The night was sultry...'
      })
      jack.reload
    }.should change(jack, :submissions_count).by(1)
  end

  it 'maintains a cached average rating' do
    users(:jill).vote!(submissions("Jack's Story"), 5)
    users(:bill).vote!(submissions("Jack's Poem"), 7)
    users(:jack).average_rating.should == 6
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
