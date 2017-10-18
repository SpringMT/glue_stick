require 'pathname'

module GlueStick::Capistrano
  class Config
    def self.role
      @role ||= fetch(:gluestick_role)
    end

    def self.log_dir
      @log_dir ||= fetch(:gluestick_log_dir)
    end
  end
end
