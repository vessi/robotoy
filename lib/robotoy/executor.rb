# frozen_string_literal: true

require 'pry'

class Robotoy
  # Commands executor class, provides CLI
  class Executor
    HELP_STRING = 'Provide commands via STDIN (e.g. cat commands | robotoy) ' \
                  'or as file argument (e.g. robotoy commands.txt). ' \
                  'File name as argument has more priority'

    class << self
      attr_reader :commands

      def execute(argf = ARGF, args = [])
        first_arg = args.first
        return HELP_STRING if %w[--help -?].include?(first_arg)
        get_commands(argf, first_arg)
        return HELP_STRING if commands.empty?
        Robotoy::Robot.new.process(commands)
      end

      private

      def get_commands(argf, filename)
        input = filename.nil? ? argf.read : File.read(filename)
        @commands = input.split("\n")
      rescue Errno::ENOENT
        @commands = []
      end
    end
  end
end
