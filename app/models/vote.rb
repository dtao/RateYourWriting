class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :submission, :counter_cache => true

  validates_presence_of :user_id
  validates_presence_of :submission_id
  validates_presence_of :rating
  validates_inclusion_of :rating, :in => (1..10), :message => 'must be between 1 and 10'
  validates_uniqueness_of :user_id, :scope => :submission_id, :message => 'already voted for this submission'
  validates_exclusion_of :user_id, :in => lambda { |vote| [vote.submission.user_id] }, :message => 'cannot vote for your own submission'

  after_save :update_submission

  def update_submission
    self.submission.vote_added!(self)
  end
end
