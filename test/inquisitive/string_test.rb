require 'test_helper'

module Inquisitive
  class StringTest < Test
    def setup
      super
      @string = Inquisitive::String.new @raw_string
    end

    include StringTests
  end
end
