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

def bonus_rolls(count, frames, idx)
  bonus_rolls = frames[idx + 1].take(count)
  if bonus_rolls.any?(&:nil?)
    bonus_rolls << frames[idx + 2].first
  end
  bonus_rolls.compact
end

def strike_with_bonus(frames, idx)
  STRIKE + bonus_rolls(2, frames, idx).sum
end

def spare_with_bonus(frames, idx)
  10 + bonus_rolls(1, frames, idx).sum
end

def final_frame?(idx)
  idx == 9
end

def strike?(rolls)
  rolls.first == STRIKE && rolls.last.nil?
end

def spare?(rolls)
  rolls.first != STRIKE && rolls.sum == 10
end

def score_nonfinal(rolls, frames, idx)
  if strike?(rolls) then strike_with_bonus(frames, idx)
  elsif spare?(rolls) then spare_with_bonus(frames, idx)
  else rolls.sum # 1〜9フレームまでの通常投球
  end
end

def score_for(frames)
  frames.each_with_index.sum do |rolls, i|
    final_frame?(i) ? rolls.sum : score_nonfinal(rolls, frames, i)
  end
end

if __FILE__ == $PROGRAM_NAME
  frames = parse_marks(ARGV[0])
  puts score_for(frames)
end
