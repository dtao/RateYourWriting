class Submission < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :title
  validates_presence_of :body
  validates_uniqueness_of :title, :scope => :user_id
end
