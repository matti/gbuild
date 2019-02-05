require "clamp"
if Clamp.respond_to? :allow_options_after_parameters
  Clamp.allow_options_after_parameters = true
end

require "kommando"
require "erb"

module Gbuild
  def self.source_bucket(project_name)
    "gs://#{project_name}_cloudbuild/gbuild-sources"
  end

  def self.logs_bucket(project_name)
    "gs://#{project_name}_cloudbuild/gbuild-logs"
  end
end

require_relative "gbuild/version"
require_relative "gbuild/template"

require_relative "gbuild/clean_command"
require_relative "gbuild/build_command"
require_relative "gbuild/delete_command"
require_relative "gbuild/version_command"

require_relative "gbuild/root_command"
