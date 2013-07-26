class User < ActiveRecord::Base
  has_secure_password

  has_many :submissions
  has_many :votes
  has_many :comments

  validates_presence_of :name
  validates_presence_of :email

  def vote!(submission, rating)
    submission.votes.create!(:user => self, :rating => rating)
  end

  def vote_for(submission)
    submission.votes.find_by_user_id(self.id)
  end
end
