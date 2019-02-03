# frozen_string_literal: true
require "tempfile"
require "securerandom"

module Gbuild
  class RootCommand < Clamp::Command
    banner "💥 gbuild #{Gbuild::VERSION}"

    option ['-v', '--version'], :flag, "Show version information" do
      puts Gbuild::VERSION
      exit 0
    end

    subcommand ["build"], "build", BuildCommand
    subcommand ["clean"], "clean", CleanCommand
    subcommand ["delete"], "delete", DeleteCommand

    def self.run
      case ARGV.first
      when nil
        super
      when "clean"
        ARGV.shift
        CleanCommand.run
      when "delete"
        ARGV.shift
        DeleteCommand.run
      else
        BuildCommand.run
      end
    end
  end
end
