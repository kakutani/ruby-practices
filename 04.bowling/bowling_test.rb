# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require_relative 'bowling'

class BowlingTest < Minitest::Test
  def test_parse_marks
    input = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
    expect = [[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10, nil], [9, 1], [8, 0], [10, nil], [6, 4, 5]]
    assert_equal expect, parse_marks(input)
  end
end
