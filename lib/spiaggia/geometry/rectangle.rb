# frozen_string_literal: true

module Spiaggia
  module Geometry
    # A generic Rectangle class, useful for collision or graphics uses.
    # Rectangle = Data.define :x1, :y1, :x2, :y2 do # (TODO: Until RBS can handle this?)
    class Rectangle < Data.define :x1, :y1, :x2, :y2 # rubocop:disable Style/DataInheritance
      def width = x2 - x1

      def height = y2 - y1

      def overlaps? other
        return false if y2 <= other.y1 || y1 >= other.y2

        return false if x2 <= other.x1 || x1 >= other.x2

        true
      end

      def & other
        return nil unless overlaps? other

        x1 = [self.x1, other.x1].max # : Numeric
        y1 = [self.y1, other.y1].max # : Numeric
        x2 = [self.x2, other.x2].min # : Numeric
        y2 = [self.y2, other.y2].min # : Numeric

        Rectangle.new x1:, y1:, x2:, y2:
      end

      def | other
        x1 = [self.x1, other.x1].min # : Numeric
        y1 = [self.y1, other.y1].min # : Numeric
        x2 = [self.x2, other.x2].max # : Numeric
        y2 = [self.y2, other.y2].max # : Numeric

        Rectangle.new x1:, y1:, x2:, y2:
      end

      def flip axis
        case axis
        when :horizontal
          Rectangle.new x1: x2, x2: x1, y1:, y2:
        when :vertical
          Rectangle.new x1:, x2:, y1: y2, y2: y1
        when :both
          Rectangle.new x1: x2, x2: x1, y1: y2, y2: y1
        else
          self
        end
      end

      def to_s = "[#{x1},#{y1}]x[#{x2},#{y2}]"
    end
  end
end
