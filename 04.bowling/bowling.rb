#!/usr/bin/env ruby
# frozen_string_literal: true

STRIKE = 10
def parse_marks(marks)
  marks.split(',').map { |m| m == 'X' ? STRIKE : m.to_i }
end
