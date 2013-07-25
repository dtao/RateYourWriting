require 'spec_helper'

describe Submission do
  let(:attributes) {
    {
      :user => users(:jack),
      :title => 'My First Submission',
      :body => 'The quick brown fox jumped over the lazy dogs.'
    }
  }

  it 'requires a user' do
    lambda { Submission.create!(attributes.except(:user)) }.should raise_error
  end

  it 'requires a title' do
    lambda { Submission.create!(attributes.except(:title)) }.should raise_error
  end

  it 'disallows duplicate titles for submissions by the same user' do
    Submission.create!(attributes)
    lambda { Submission.create!(attributes) }.should raise_error
  end

  it 'allows two different users to have submissions with the same title' do
    lambda {
      Submission.create!(attributes)
      Submission.create!(attributes.merge(:user => users(:jill)))
    }.should change(Submission, :count).by(2)
  end

  it 'requires a body' do
    lambda { Submission.create!(attributes.except(:body)) }.should raise_error
  end

  it 'maintains a counter cache for vote count' do
    jills_story = submissions("Jill's Story")
    lambda {
      users(:jack).vote!(jills_story, 8)
      jills_story.reload
    }.should change(jills_story, :votes_count).by(1)
  end

  it 'maintains a cached average rating' do
    jills_story = submissions("Jill's Story")
    users(:jack).vote!(jills_story, 8)
    users(:bill).vote!(jills_story, 7)

    jills_story.reload
    jills_story.rating.should == 7.5
  end
end
