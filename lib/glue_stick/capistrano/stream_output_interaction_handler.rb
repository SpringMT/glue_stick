module GlueStick::Capistrano
  class StreamOutputInteractionHandler
    def initialize(log_level=:info)
      @log_level = log_level
    end

    def on_data(_command, stream_name, data, channel)
      log(data)
    end

    private

    def log(message)
      SSHKit.config.output.send(@log_level, message) unless @log_level.nil?
    end
  end
end