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

def strike_with_bonus(frames, idx)
  next_frame_idx = idx + 1
  next_rolls = frames[next_frame_idx]
  # ストライク連続じゃない
  bonus = case next_rolls.compact.size
          # ストライクが連続
          when 1
            next_rolls.first + frames[idx + 2].first
          when 2
            next_rolls.sum
          when 3
            next_rolls.take(2).sum
          end
  STRIKE + bonus
end

def spare_with_bonus(frames, idx)
  next_frame_idx = idx + 1
  next_rolls = frames[next_frame_idx]
  bonus = next_rolls.first
  10 + bonus
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
