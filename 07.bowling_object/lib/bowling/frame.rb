# frozen_string_literal: true

require_relative 'frame/bonus'
require_relative 'frame/builder'

module Bowling
  class Frame
    class << self
      def builder(marks) = Builder.new(marks)
    end

    def initialize(rolls:, bonus:)
      @rolls, @bonus = rolls, bonus # rubocop:disable Style/ParallelAssignment
    end

    def score
      (@rolls + @bonus).sum
    end
  end
end
