class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :submission, :counter_cache => true

  validates_presence_of :user_id
  validates_presence_of :submission_id
  validates_presence_of :content
end
