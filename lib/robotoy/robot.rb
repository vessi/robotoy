# frozen_string_literal: true

class Robotoy
  # Robot class, it gets commands array and process them one by one
  class Robot
    X_BOUNDS = (0...5)
    Y_BOUNDS = (0...5)
    DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

    attr_reader :position

    def perform_command(command)
      return unless position || command =~ /place (\d),(\d),(north|south|west|east)/i
      parse_command(command)
    end

    def parse_command(command)
      case command
      when /place (\d),(\d),(north|south|west|east)/i
        set_position(Regexp.last_match(1), Regexp.last_match(2), Regexp.last_match(3)) && return # no return here
      when /(left|right)/i
        rotate(Regexp.last_match(1)) && return # no return here
      when /move/i
        move && return # no return here
      when /report/i
        report
      end
    end

    def rotate(direction_word)
      direction = DIRECTIONS.index(position[:facing])
      facing =  case direction_word
                when /left/i
                  (direction - 1).negative? ? DIRECTIONS.last : DIRECTIONS[direction - 1]
                when /right/i
                  direction + 1 > DIRECTIONS.length - 1 ? DIRECTIONS.first : DIRECTIONS[direction + 1]
                end
      set_position(position[:x], position[:y], facing)
    end

    def move
      x, y, facing = position.values_at(:x, :y, :facing)
      case facing
      when /north/i
        set_position(x, y + 1, facing) if Y_BOUNDS.include?(y + 1)
      when /south/i
        set_position(x, y - 1, facing) if Y_BOUNDS.include?(y - 1)
      when /east/i
        set_position(x + 1, y, facing) if X_BOUNDS.include?(x + 1)
      when /west/i
        set_position(x - 1, y, facing) if X_BOUNDS.include?(x - 1)
      end
    end

    def set_position(x, y, facing)
      @position = { x: x.to_i, y: y.to_i, facing: facing.upcase }
    end

    def report
      [position[:x], position[:y], position[:facing]].join(',')
    end

    def process(commands = [])
      commands.map { |command| perform_command(command) }.compact.join("\n")
    end
  end
end
