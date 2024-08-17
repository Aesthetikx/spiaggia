# frozen_string_literal: true

module Spiaggia
  module Input
    # An Input::Handler receives Input::Events, and returns true if they are handled, false otherwise.
    module Handler
      def handle event:
        case event
        when KeyPress   then handle_key_press   key: event.key
        when KeyRelease then handle_key_release key: event.key
        else false
        end
      end

      private

      def handle_key_press key: # rubocop:disable Lint/UnusedMethodArgument
        false
      end

      def handle_key_release key: # rubocop:disable Lint/UnusedMethodArgument
        false
      end
    end
  end
end
