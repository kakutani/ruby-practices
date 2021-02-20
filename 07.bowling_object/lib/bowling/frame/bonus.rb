# frozen_string_literal: true

module Bowling
  class Frame
    module Bonus
      class << self
        def frame_if(sym, pins) = bonus?(sym, pins) && bonus(sym).frame(pins)

        def strike?(pins) = bonus?(:strike, pins)

        private

        def bonus?(sym, pins) = bonus(sym).satisfied_by?(pins)

        def bonus(sym) = const_get(sym.capitalize)
      end

      module Strike
        class << self
          def point = 10

          def satisfied_by?(pins) = pins.first == Strike.point

          def frame(pins) = { rolls: [pins.shift], bonus: pins.take(2) }
        end
      end

      module Spare
        class << self
          def point = 10

          def satisfied_by?(pins) = !Bonus.strike?(pins) && spare_rolls?(pins)

          def frame(pins) = { rolls: pins.shift(2), bonus: pins.take(1) }

          private

          def spare_rolls?(pins) = pins.take(2).sum == Spare.point
        end
      end

      module MarkXasStrike
        refine String do
          def to_i(base = 10) = (self == 'X' ? Strike.point : super)
        end
      end
    end
  end
end
