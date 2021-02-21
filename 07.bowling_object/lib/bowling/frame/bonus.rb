# frozen_string_literal: true

module Bowling
  class Frame
    module Bonus
      class << self
        def frame_if(sym, pins)
          bonus?(sym, pins) && bonus(sym).frame(pins)
        end

        def strike?(pins) = bonus?(:strike, pins)

        private

        def bonus?(sym, pins)
          bonus(sym).satisfied?(pins)
        end

        def bonus(sym) = const_get(sym.capitalize)
      end

      module Strike
        class << self
          def point = 10

          def satisfied?(pins)
            pins.first == Strike.point
          end

          def frame(pins)
            { rolls: [pins.shift], bonus: pins.take(2) }
          end
        end
      end

      module Spare
        class << self
          def point = 10

          def satisfied?(pins)
            !Bonus.strike?(pins) && spare_rolls?(pins)
          end

          def frame(pins)
            { rolls: pins.shift(2), bonus: pins.take(1) }
          end

          private

          def spare_rolls?(pins) = (pins.take(2).sum == Spare.point)
        end
      end

      module MarkXasStrike
        refine String do
          def to_i(base = 10)
            (self == 'X' ? Strike.point : super)
          end
        end
      end
    end
  end
end
