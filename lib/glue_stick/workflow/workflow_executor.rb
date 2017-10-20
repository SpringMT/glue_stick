module GlueStick::Workflow
  class WorkflowExecutor
    def initialize(workflow, session_storage)
      @workflow = workflow
      @session_storage
    end

    def run
      before_run

      after_run
    end

    def before_run

    end

    def after_run

    end
  end
end
