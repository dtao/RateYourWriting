require 'has_token'

class SingleUseNotice < ActiveRecord::Base
  include HasToken

  belongs_to :user

  def use_and_destroy!
    begin
      return [self.message, self.notice_type]
    ensure
      self.destroy!
    end
  end
end
