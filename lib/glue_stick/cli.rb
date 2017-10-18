require 'thor'
require 'yaml'
require 'open3'
require 'glue_stick/command'

module GlueStick
  class CLI < Thor

    desc 'generate', 'generate task yaml'
    def generate
    end

    desc 'execute', 'execute task'
    def execute(task_name, log_dir = './.glue_stick')
      config = GlueStick::Config.new
      file_name = "#{task_name}.yml"
      log_path = Pathname.new(log_dir)
      # 初期設定
      tasks = YAML.load_file(config.task_path.join(file_name))
      tasks['deploy']['tasks'].each do |task|
        command = GlueStick::Command.new(task_name, task, log_path)
        # command info
        puts command
        command.execute
      end
      # 前処理
      # yamlファイルをloadして
      # 順々に実行して
      # 実行結果を保存し
      # 後処理
    end

    private

    def record_result

    end
  end
end
