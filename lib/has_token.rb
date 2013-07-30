module HasToken
  def self.included(base)
    base.before_create :generate_token
  end

  def generate_token
    self.token ||= Randy.string(30)
  end
end
