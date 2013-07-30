require 'has_token'

class VerificationToken < ActiveRecord::Base
  include HasToken

  belongs_to :user
end
