module GlueStick::Capistrano
  class Config
    def self.role
      @role ||= fetch(:gluestick_role)
    end
  end
end
