# frozen_string_literal: true

module Spiaggia
  module Game
    # A Clock to keep track of elapsed time and frame durations.
    # Call #tick! at the beginning of every update,
    # and #tock! at the end of the update.
    class Clock
      attr_reader :start_tick,
                  :current_tick,
                  :last_tick,
                  :last_tock,
                  :frame_duration,
                  :draw_duration,
                  :inbetween_duration,
                  :elapsed,
                  :frame,
                  :frame_rate

      def initialize target_frame_rate: 60.0
        @target_frame_rate = target_frame_rate
        @frame = 0
        @recent = []
      end

      def tick!
        @current_tick = Time.now

        start unless @started

        @frame += 1
        @elapsed = @current_tick - @start_tick
        @frame_duration = @current_tick - @last_tick
        @draw_duration = @last_tock - @last_tick
        @inbetween_duration = @current_tick - @last_tock

        @frame_rate = 1.0 / @frame_duration

        @recent << @frame_duration
        @recent.shift if @recent.size > 100
      end

      def tock!
        @last_tick = @current_tick
        @last_tock = Time.now
      end

      def new_second?
        @current_tick.sec != @last_tick.sec
      end

      def to_s # rubocop:disable Metrics
        draw_ms = draw_duration * 1000
        recent_max_ms = @recent.max * 1000
        recent_min_ms = @recent.min * 1000
        frame_percentage = (frame_usage * 100).to_i

        [
          "#{format "%.2f", frame_rate} FPS",
          "#{format "%.2f", elapsed}s Elapsed",
          "#{format "%.2f", draw_ms}ms Draw (#{frame_percentage}%)",
          "#{format "%.2f", recent_max_ms}ms Recent Max",
          "#{format "%.2f", recent_min_ms}ms Recent Min"
        ].join(", ")
      end

      private

      def start
        @start_tick = @current_tick
        @last_tick = @current_tick
        @last_tock = @current_tick
        @started = true
      end

      def frame_usage
        max_usage = 1.0 / @target_frame_rate # : Float

        @draw_duration / max_usage
      end
    end
  end
end
