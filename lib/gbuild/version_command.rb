# frozen_string_literal: true

module Gbuild
  class VersionCommand < Clamp::Command
    def execute
      puts Gbuild::VERSION
    end
  end
end
