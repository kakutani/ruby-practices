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

    def create_frames
      (0..final_frame).map { |i| build_frame(final?(i)) }
    end

    def build_frame(final)
      @frame_builder.call(final)
    end

    def final?(index) = (index == final_frame)

    def final_frame = 9
  end
end
