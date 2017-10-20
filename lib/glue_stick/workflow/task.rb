require 'open3'
require 'yaml'
require 'fileutils'
require 'pathname'

module GlueStick::WorkFlow
  class Task
    def initialize(task)
      @name = task['name']
      @description = task['description']
      @command = task['command']
      @task_log_path = log_path.join(@task_name)
      @exit_status = nil
    end

    def to_s
      <<-DESC
name: #{@name} in #{@task_name}
description: #{@description}
command: #{@command}
      DESC
    end

    def result_file
      @task_log_path.join(@name).sub_ext('.yml')
    end

    def execute
      # mkdir datadir
      FileUtils.mkdir_p(@task_log_path)
      # lockかける 上段でかけたほうがよさそう。。

      # すでに実行結果があり、成功していれば終了
      # 今のところ先勝にする
      if result_file.exist?
        result = YAML.load_file(result_file)
        if result[:status] == 'success'
          p 'Already executed and succeeded'
          return
        end
      end

      if @command
        execute_command
      else
        @exit_status = 0
      end

      if success?
        File.open(result_file, 'w+') do |f|
          f.write(YAML.dump({status: 'success'}))
        end
      else
        File.open(result_file, 'w+') do |f|
          f.write(YAML.dump({status: 'failure'}))
        end
        raise StandardError if failure?
      end
    end

    def success?
      @exit_status.nil? ? false : @exit_status.to_i == 0
    end

    def execute_command
      Bundler.with_clean_env do
        Open3.popen3(@command) do |stdin, stdout, stderr, wait_thr|
          stdout_thread = Thread.new do
            while (line = stdout.gets) do
              #cmd.on_stdout(stdin, line)
              #output.log_command_data(cmd, :stdout, line)
              # loggerに置き換える
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
          @exit_status = wait_thr.value.to_i
          p 'finish'
          #output.log_command_exit(cmd)
          #record_result
        end
      end
    end

  end
end

