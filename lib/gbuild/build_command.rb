# frozen_string_literal: true
require "tempfile"

module Gbuild
  class BuildCommand < Clamp::Command
    parameter "IMAGE", "GCR URL (gcr.io/project/image)"
    option "--context", "CONTEXT", "build context, defaults to current working directory"
    option "--build-arg", "BUILD_ARG", "docker build argument, can be given multiple times", multivalued: true

    option "--[no-]cache", :flag, "cache layers", default: true
    option "--[no-]clean-source", :flag, "clean source", default: true
    option "--[no-]clean-log", :flag, "clean log", default: true

    option "--debug", :flag, "debug", default: false

    option "--dockerfile", "DOCKERFILE", "path to Dockerfile", default: nil
    option "--project", "PROJECT", "gcloud project, defaults to project part in GCR URL"
    option "--timeout", "TIMEOUT", "build timeout"

    def execute
      project_name = unless project
        _, project_from_image, _ = image.split("/")
        project_from_image
      else
        project
      end

      build_source = "#{Gbuild.source_bucket(project_name)}/#{SecureRandom.uuid}"
      build_log = "#{Gbuild.logs_bucket(project_name)}/#{SecureRandom.uuid}"

      t = Template.new "build.yaml"
      t.set :image, image
      t.set :dockerfile, dockerfile if dockerfile
      t.set :build_args, build_arg_list
      t.set :cache, (cache? ? "true" : "false")
      t.set :debug, debug?

      gcloud_config = Tempfile.new
      File.write gcloud_config.path, t.result

      puts t.result if debug?

      cmd = ["gcloud","builds","submit"]
      cmd << context unless context == {}

      cmd += ["--gcs-log-dir", build_source]
      cmd += ["--gcs-source-staging-dir", build_log]

      cmd += ["--config", gcloud_config.path]
      cmd += ["--timeout", timeout] if timeout
      cmd += ["--project", project_name]

      build_cmd = cmd.join " "
      puts build_cmd if debug?
      build_k = Kommando.new build_cmd, output: true
      build_k.run

      waits = []
      if clean_source?
        puts "removing source from #{build_source}"
        waits << (Kommando.run_async "gsutil rm -r #{build_source}")
      end
      if clean_log?
        puts "removing log from #{build_log}"
        waits << (Kommando.run_async "gsutil rm -r #{build_log}")
      end
      waits.each { |k| k.wait }
    end
  end
end
