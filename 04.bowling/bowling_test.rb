# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require_relative 'bowling'

class BowlingTest < Minitest::Test
  def calculate_score(input)
    frames = parse_marks(input)
    score_for(frames)
  end

  def test_score1
    marks = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
    assert_equal 139, calculate_score(marks)
  end

  def test_score2
    marks = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'
    assert_equal 164, calculate_score(marks)
  end

  def test_score3
    marks = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'
    assert_equal 107, calculate_score(marks)
  end

  def test_parse_marks4
    input = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'
    expect = [
      [6, 3],
      [9, 0],
      [0, 3],
      [8, 2],
      [7, 3],
      [10, nil],
      [9, 1],
      [8, 0],
      [10, nil],
      [10, 0, 0]
    ]
    assert_equal expect, parse_marks(input)
  end

  def test_parse_marks5
    input = 'X,X,X,X,X,X,X,X,X,X,X,X'
    expect = [
      [10, nil],
      [10, nil],
      [10, nil],
      [10, nil],
      [10, nil],
      [10, nil],
      [10, nil],
      [10, nil],
      [10, nil],
      [10, 10, 10]
    ]
    assert_equal expect, parse_marks(input)
  end
end
