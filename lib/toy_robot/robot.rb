# frozen_string_literal: true

module ToyRobot
  # Represents a robot on the platform. Handles placement, movement,
  # rotation, and reporting its current position and facing direction.
  class Robot
    DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

    attr_reader :x, :y, :facing

    def initialize(platform)
      @platform = platform
      @placed = false
    end

    def placed?
      @placed
    end

    def place(x, y, facing)
      unless @platform.valid_position?(x, y) && DIRECTIONS.include?(facing)
        warn '❌ Invalid placement.'
        return
      end

      @x, @y, @facing, @placed = x, y, facing, true

      puts "✅ Robot placed at (#{x}, #{y}) facing #{facing}."
    end

    def move
      ensure_placed!
      new_x, new_y = next_position

      if @platform.valid_position?(new_x, new_y)
        @x, @y = new_x, new_y

        puts "🚶 Robot moved to (#{x}, #{y})."
      else
        warn '🧱 Move blocked — edge of the platform.'
      end
    end

    def left
      ensure_placed!
      @facing = DIRECTIONS[(DIRECTIONS.index(@facing) - 1) % DIRECTIONS.size]

      puts "↪️ Turned left. Now facing #{@facing}."
    end

    def right
      ensure_placed!
      @facing = DIRECTIONS[(DIRECTIONS.index(@facing) + 1) % DIRECTIONS.size]

      puts "↩️ Turned right. Now facing #{@facing}."
    end

    def report
      ensure_placed!

      puts "📍 Position: (#{x}, #{y}), Facing: #{facing}"
    end

    private

    def next_position
      case @facing
      when 'NORTH' then [@x, @y + 1]
      when 'EAST'  then [@x + 1, @y]
      when 'SOUTH' then [@x, @y - 1]
      when 'WEST'  then [@x - 1, @y]
      end
    end

    def ensure_placed!
      raise 'Robot is not placed yet!' unless placed?
    rescue RuntimeError => e
      warn "⚠️  #{e.message}"

      throw :skip_command
    end
  end
end
