class User < ActiveRecord::Base
  has_secure_password

  has_one  :preferences, :class_name => 'UserPreferences'
  has_many :submissions
  has_many :votes
  has_many :comments
  has_many :quotes

  validates_presence_of :name
  validates_presence_of :email

  def vote!(submission, rating)
    submission.votes.create!(:user => self, :rating => rating)
  end

  def comment!(submission, comment)
    submission.comments.create!(:user => self, :content => comment)
  end

  def vote_for(submission)
    submission.votes.find_by_user_id(self.id)
  end

  def vote_added!(vote)
    self.update_attributes(:average_rating => self.submissions.average(:rating))
  end
end
