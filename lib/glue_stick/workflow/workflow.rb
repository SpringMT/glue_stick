require 'pathname'

module GlueStick::Workflow
  class Workflow
    def initialize(workflow, workflow_dir)
      @workflow = workflow
      @workflow_path = workflow_dir || Pathname.new('tasks')
      @tasks = []
    end

    def build_task
      workflow_file = "#{@workflow}.yml"
      tasks = YAML.load_file(@log_path.join(workflow_file))
      @tasks = tasks['tasks'].map { |t| GlueStick::Workflow::Task.new(t) }
    end

    def to_s
      strings = "workflow: #{@workflow}\n"
      @tasks.each do |t|
        strings << t.to_s
      end
      strings
    end
  end
end
