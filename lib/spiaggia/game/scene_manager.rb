# frozen_string_literal: true

module Spiaggia
  module Game
    # Manages a lifecycle of a stack of Scenes
    class SceneManager
      def initialize
        @scenes = []
      end

      def current_scene
        @scenes.last
      end

      def push scene:
        current_scene&.pause

        @scenes.push scene

        scene.start

        scene
      end

      def replace scene:
        current_scene&.stop

        @scenes.pop

        @scenes.push scene

        scene.start

        scene
      end

      def pop
        current_scene&.stop

        @scenes.pop.tap do
          current_scene&.resume
        end
      end
    end
  end
end
