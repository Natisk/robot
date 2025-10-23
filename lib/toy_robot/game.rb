# frozen_string_literal: true

module ToyRobot
  # Represents the rectangular platform on which the robot can move.
  # Handles the platform dimensions and checks whether given coordinates
  # are valid positions within its boundaries.
  class Game
    def initialize
      @platform = ToyRobot::Platform.new
      @robot = ToyRobot::Robot.new(@platform)
    end

    def start
      print_intro

      loop do
        print "\n👉 Enter command: "
        input = gets&.strip
        break unless input
        break if input.casecmp('exit').zero?

        catch(:skip_command) { handle_command(input) }
      end

      puts "\n👋 Game over!"
    end

    private

    def handle_command(input)
      command, args = input.to_s.strip.split(/\s+/, 2)
      return if command.nil? || command.empty?

      case command.upcase
      when 'PLACE'  then handle_place(args)
      when 'MOVE'   then @robot.move
      when 'LEFT'   then @robot.left
      when 'RIGHT'  then @robot.right
      when 'REPORT' then @robot.report
      else
        warn '❌ Unknown command.'
      end
    end

    def handle_place(args)
      x_str, y_str, facing = args.to_s.split(',').map(&:strip)

      return warn '❌ PLACE requires 3 arguments: X,Y,FACING' if [x_str, y_str, facing].any?(&:nil?)

      x, y = x_str.to_i, y_str.to_i
      @robot.place(x, y, facing.upcase)
    end

    def print_intro
      puts <<~INTRO
        🤖 Welcome to TOY ROBOT!
        Available commands:
          PLACE X,Y,DIRECTION (example: PLACE 0,0,NORTH)
          MOVE, LEFT, RIGHT, REPORT, EXIT
      INTRO
    end
  end
end
