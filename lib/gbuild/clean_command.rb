# frozen_string_literal: true

module Gbuild
  class CleanCommand < Clamp::Command
    parameter "PROJECT", "project"

    def execute
      Kommando.run "gsutil rm -r #{Gbuild.source_bucket(project)}", output: true
      Kommando.run "gsutil rm -r #{Gbuild.source_bucket(project)}", output: true
    end
  end
end
