#!/usr/bin/env ruby
# frozen_string_literal: true

STRIKE = 10
def parse_marks(marks)
  pins = marks.split(',').map { |m| m == 'X' ? STRIKE : m.to_i }
  frames = []
  9.times do
    rolls = pins.shift(2)
    if rolls.first == STRIKE
      frames << [rolls.first, nil] # 2投目は投げていない
      pins.unshift(rolls.last) # 取りすぎなので戻す
    else
      frames << rolls
    end
  end
  frames << pins # 最後に残ったのが10フレーム目
end
