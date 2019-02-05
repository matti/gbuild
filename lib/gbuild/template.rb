module Gbuild
  class Template
    def initialize(name)
      path = File.expand_path(
        File.join(__dir__, "..","..", "templates", name)
      )

      @__erb = if RUBY_VERSION >= '2.6'
        ERB.new(File.read(path), trim_mode: '<>')
      else
        ERB.new(File.read(path), nil, '<>')
      end
    end

    def set(key, value)
      instance_variable_set "@#{key}", value
    end

    def result
      @__erb.result binding
    end
  end
end
