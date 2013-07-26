class Submission < ActiveRecord::Base
  KINDS = {
    'Poem' => 'P',
    'Short Story' => 'S',
    'Song Lyrics' => 'L',
    'Book Excerpt' => 'B',
    'Other (e.g., essay)' => 'O'
  }

  KIND_LOOKUP = KINDS.invert

  belongs_to :user, :counter_cache => true

  has_many :votes
  has_many :comments

  validates_presence_of :user_id
  validates_inclusion_of :kind, :in => KINDS.values
  validates_presence_of :title
  validates_presence_of :body
  validates_uniqueness_of :title, :scope => :user_id

  # TODO: Figure out how the heck to prevent ActiveRecord from loading the body
  # of every submission into memory by default.
  before_save :set_length

  def word_count
    (self.length / 5).to_i
  end

  def set_length
    if self.body_changed?
      self.length = self.body.length
    end
  end

  def vote_added!(vote)
    self.update_attributes({
      :rating => self.votes.average(:rating),
      :last_vote => vote.created_at
    })
  end

  def comment_added!(comment)
    self.update_attributes(:last_comment => comment.created_at)
  end
end
