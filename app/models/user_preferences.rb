class UserPreferences < ActiveRecord::Base
  self.table_name = 'user_preferences'

  THEMES = [
    'amelia',
    'cerulean',
    'cosmo',
    'cyborg',
    'flatly',
    'journal',
    'readable',
    'simplex',
    'slate',
    'spacelab',
    'superhero',
    'united'
  ]

  DEFAULT_THEME = 'cerulean'

  belongs_to :user

  validates_presence_of :user_id
  validates_inclusion_of :theme, :in => THEMES
end
