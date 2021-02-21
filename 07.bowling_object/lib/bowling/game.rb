# frozen_string_literal: true

module Bowling
  class Game
    def initialize(marks)
      @frame_builder = Frame.builder(marks)
    end

    def score
      frames.sum(&:score)
    end

    private

    def frames = (@frames ||= create_frames)

    def create_frames = Array.new(frame_size){ build_frame(final?(_1)) }

    def build_frame(final) = @frame_builder.call(final)

    def final?(index) = (index == final_frame)

    def final_frame = 9

    def frame_size = 10
  end
end
