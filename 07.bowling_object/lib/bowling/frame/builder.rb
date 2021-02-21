# frozen_string_literal: true

module Bowling
  class Frame
    class Builder
      def initialize(marks)
        @marks = marks
      end

      def call(final)
        Frame.new(**(final ? final_frame : nonfinal_frame))
      end

      private

      def final_frame = { rolls: pins.shift(3), bonus: [] }

      def nonfinal_frame
        frame_if(:strike) || frame_if(:spare) || open_frame
      end

      def frame_if(bonus) = Bonus.frame_if(bonus, pins)

      def open_frame = { rolls: pins.shift(2), bonus: [] }

      using Bonus::MarkXasStrike
      def pins = (@pins ||= parse_marks)

      def parse_marks = @marks.split(',').map(&:to_i)
    end
  end
end
