# frozen_string_literal: true

module ToyRobot
  class Game
    def initialize
      @platform = Platform.new
      @robot = Robot.new(@platform)
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
      command, args = input.split(' ', 2)
      case command&.upcase
      when 'PLACE'
        x, y, facing = args&.split(',')&.map(&:strip)
        @robot.place(x.to_i, y.to_i, facing&.upcase)
      when 'MOVE'   then @robot.move
      when 'LEFT'   then @robot.left
      when 'RIGHT'  then @robot.right
      when 'REPORT' then @robot.report
      else
        warn "❌ Unknown command."
      end
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
