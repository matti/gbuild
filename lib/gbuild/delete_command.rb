# frozen_string_literal: true

module Gbuild
  class DeleteCommand < Clamp::Command
    parameter "IMAGE", "image to delete"

    def execute
      Kommando.run "gcloud container images delete #{image} --quiet --force-delete-tags", output: true
    end
  end
end
