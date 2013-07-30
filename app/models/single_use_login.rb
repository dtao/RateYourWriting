class SingleUseLogin < ActiveRecord::Base
  include HasToken

  belongs_to :user

  def use_and_destroy!
    begin
      return self.user
    ensure
      self.destroy!
    end
  end
end
