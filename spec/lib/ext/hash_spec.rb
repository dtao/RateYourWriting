require 'spec_helper'
require 'ext/hash'

describe Hash do
  describe '#compact' do
    it 'removes the keys from a hash whose values are nil' do
      { :foo => 'foo', :bar => nil }.compact.should == { :foo => 'foo' }
    end

    it 'does not mutate the original hash' do
      original = { :foo => 'foo', :bar => nil }
      original.compact.should == { :foo => 'foo' }
      original.should == { :foo => 'foo', :bar => nil }
    end
  end
end
