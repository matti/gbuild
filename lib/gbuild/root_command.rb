# frozen_string_literal: true
require "tempfile"
require "securerandom"

module Gbuild
  class RootCommand < Clamp::Command
    banner "💥 gbuild #{Gbuild::VERSION}"

    subcommand ["build"], "build", BuildCommand
    subcommand ["clean"], "clean", CleanCommand
    subcommand ["delete"], "delete", DeleteCommand
    subcommand ["version"], "version", VersionCommand

    def self.run
      case ARGV.first
      when nil
        super
      when "build"
        ARGV.shift
        BuildCommand.run
      when "version"
        ARGV.shift
        VersionCommand.run
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
