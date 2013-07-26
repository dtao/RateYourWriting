class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :submission, :counter_cache => true
end
