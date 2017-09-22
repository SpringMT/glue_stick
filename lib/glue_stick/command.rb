module GlueStick
  class Command
    def initialize(command, name)
      @name
      @command = command
      @exit_status = nil
    end

    def success?
      @exit_status.nil? ? false : @exit_status.to_i == 0
    end

    def failure?
      @exit_status.to_i > 0
    end

    def to_command
      @command
    end

    def exit_status=(new_exit_status)
      @exit_status = new_exit_status
    end
  end
end
