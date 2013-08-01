class Revision < ActiveRecord::Base
  has_one :user, :through => :submission
  belongs_to :submission

  validates_inclusion_of :kind, :in => Submission::KINDS.values
  validates_presence_of :title
  validates_presence_of :body
end
