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

    def frames = (@frames ||= Array.new(10){ build_frame(final?(_1)) })

    def build_frame(final) = @frame_builder.call(final)

    def final?(index) = (index == 9)
  end
end
