# frozen_string_literal: true

module Spiaggia
  module Game
    # A base class useful for implementing a game loop.
    class Base
      attr_reader :clock

      def initialize
        @clock = Spiaggia::Game::Clock.new
      end

      def before_frame
        clock.tick!
      end

      def update; end

      def render; end

      def after_frame
        clock.tock!
      end
    end
  end
end
