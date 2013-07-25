class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :submission, :counter_cache => true

  validates_presence_of :user_id
  validates_presence_of :submission_id
  validates_presence_of :rating
  validates_inclusion_of :rating, :in => (1..10)
  validates_uniqueness_of :user_id, :scope => :submission_id

  after_save :update_submission_rating

  def update_submission_rating
    self.submission.update_rating!
  end
end
