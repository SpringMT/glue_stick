unless defined?(GlueStick::Capistrano::TASK_LOADED) # prevent multiple loads
  GlueStick::Capistrano::TASK_LOADED = true

  require 'glue_stick'
  require 'fileutils'
  require 'pathname'
  require 'glue_stick/capistrano/stream_output_interaction_handler'

  namespace :glue_stick do
    def capistrano_config
      GlueStick::Capistrano::Config
    end

    desc 'Check daemon settings'
    task :run, :job do |task, args|
      job = args[:job]
      # 実行
      on release_roles(capistrano_config.role) do
        within current_path do
          execute :bundle, "exec glue execute #{job} #{capistrano_config.log_dir}"
        end
      end
    end
  end
end
