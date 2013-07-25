class Submission < ActiveRecord::Base
  belongs_to :user

  has_many :votes

  validates_presence_of :user_id
  validates_presence_of :title
  validates_presence_of :body
  validates_uniqueness_of :title, :scope => :user_id

  def update_rating!
    self.rating = self.votes.average(:rating)
    self.save!
  end
end
