class VerificationToken < ActiveRecord::Base
  belongs_to :user

  before_create :generate_token

  def generate_token
    self.token ||= Randy.string(30)
  end
end
