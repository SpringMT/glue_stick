require 'thor'
require 'yaml'
require 'open3'

module GlueStick
  class CLI < Thor

    desc 'generate', 'generate task yaml'
    def generate

    end

    desc 'execute','execute task'
    def execute(task_name)
      config = GlueStick::Config.new
      file_name = "#{task_name}.yml"
      # 初期設定
      tasks = YAML.load_file(config.task_path.join(file_name))
      tasks['deploy']['tasks'].each do |task|
        p task['name']
        p task['description']
        next unless task['command']
        command = Command.new(task['command'], task: task['name'])
        Open3.popen3(command.to_command) do |stdin, stdout, stderr, wait_thr|
          stdout_thread = Thread.new do
            while (line = stdout.gets) do
              #cmd.on_stdout(stdin, line)
              #output.log_command_data(cmd, :stdout, line)
              p line
            end
          end

          stderr_thread = Thread.new do
            while (line = stderr.gets) do
              #cmd.on_stderr(stdin, line)
              #output.log_command_data(cmd, :stderr, line)
              p line
            end
          end

          stdout_thread.join
          stderr_thread.join

          command.exit_status = wait_thr.value.to_i

          p 'finish'
          #output.log_command_exit(cmd)
          record_result
          raise StandardError if command.failure?
        end
        p command
      end
      # 前処理
      # yamlファイルをloadして
      # 順々に実行して
      # 実行結果を保存し
      # 後処理
    end

    def record_result

    end
  end
end
