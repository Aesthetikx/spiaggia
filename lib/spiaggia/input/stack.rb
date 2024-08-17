# frozen_string_literal: true

module Spiaggia
  module Input
    # An Input::Stack registers and unregisters Input::Handlers.
    # It receives Input::Events and propogates them down the stack to the first handler that responds to the input.
    class Stack
      attr_reader :handlers

      def initialize
        @handlers = []
      end

      def register handler:
        @handlers.unshift handler

        if block_given?
          begin
            yield handler
          ensure
            unregister handler:
          end
        end

        handler
      end

      def unregister handler:
        @handlers.delete handler
      end

      def handle event:
        @handlers.any? { |handler| handler.handle event: }
      end
    end
  end
end
