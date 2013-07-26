class NewsItem < ActiveRecord::Base
  KINDS = {
    'General' => 'G',
    'Site' => 'S'
  }

  belongs_to :user

  validates_presence_of :user_id
  validates_inclusion_of :kind, :in => KINDS.values
  validates_presence_of :headline
  validates_presence_of :content

  scope :daily, lambda { where(:kind => 'G') }
  scope :site, lambda { where(:kind => 'S') }
  scope :latest, lambda { order(:id => :desc).limit(10) }
end
