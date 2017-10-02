unless defined?(GlueStick::Capistrano::TASK_LOADED) # prevent multiple loads
  GlueStick::Capistrano::TASK_LOADED = true

  require 'glue_stick'
  require 'fileutils'
  require 'pathname'

  namespace :glue_stick do
    def capistrano_config
      GlueStick::Capistrano::Config
    end

    desc 'Check daemon settings'
    task :run, :command do |task, args|
      command = args[:command]
      glue_stick = GlueStick.new(command: command)

      # 実行
      on release_roles(capistrano_config.role) do
        within current_path do
          execute :bundle, "exec glue_stick #{command} --path #{yaml_path}"
        end
      end
    end
  end
end
