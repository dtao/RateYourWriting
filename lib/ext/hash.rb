class Hash
  def compact
    compacted = {}
    self.each do |key, value|
      compacted[key] = value unless value.nil?
    end
    compacted
  end
end
