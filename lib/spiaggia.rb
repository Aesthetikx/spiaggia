# frozen_string_literal: true

require "zeitwerk"

loader = Zeitwerk::Loader.for_gem # steep:ignore UnknownConstant
loader.setup

module Spiaggia
  class Error < StandardError; end
end

loader.eager_load
