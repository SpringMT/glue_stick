require 'pathname'

module GlueStick
  class Config
    attr_accessor :task_path

    def initialize(_options = {})
      @task_path = Pathname.new('task')
    end
  end
end