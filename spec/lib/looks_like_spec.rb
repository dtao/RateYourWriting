require 'spec_helper'
require 'looks_like'

describe LooksLike do
  describe '::email?' do
    it 'matches strings that look like e-mail addresses' do
      LooksLike.email?('daniel.tao@gmail.com').should be_true
    end

    it 'does not match ordinary strings' do
      LooksLike.email?('foo').should be_false
    end
  end
end
