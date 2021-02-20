# frozen_string_literal: true

module Bowling
  class Game
    def initialize(marks) = @frame_builder = Frame.builder(marks)

    def score = frames.sum(&:score)

    private

    def frames = @frames ||= create_frames

    def create_frames = (0..final_frame).map { |i| build_frame(final?(i)) }

    def build_frame(final) = @frame_builder.call(final)

    def final?(index) = (index == final_frame)

    def final_frame = 9
  end
end
