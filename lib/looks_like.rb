module LooksLike
  def self.email?(string)
    string =~ /^[^@]+@[^@]+$/
  end
end
