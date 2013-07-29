class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'

  validates_presence_of :sender_id
  validates_presence_of :recipient_id
  validates_presence_of :body
end
