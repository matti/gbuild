module Gbuild
  class Template
    def initialize(name)
      path = File.expand_path(
        File.join(__dir__, "..","..", "templates", name)
      )

      @__erb = ERB.new File.read(path), trim_mode: "<>"
    end

    def set(key, value)
      instance_variable_set "@#{key}", value
    end

    def result
      @__erb.result binding
    end
  end
end
