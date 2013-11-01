class Platform

  attr_reader :width, :height

  def initialize(width_x = 5, height_y = 6)
    @width = width_x
    @height = height_y
  end

end

class Robot

  attr_accessor :x, :y, :direction

  DIRECTION = %w[NORTH EAST SOUTH WEST]

	def initialize(x = 0, y = 0)
		@y = y
		@x = x
    @side = 0
    @alive = false
    puts 'Robot is complete'
	end

	def place(x, y, direction)
    @area = Platform.new(5, 6)
		if 0 <= y && y <= @area.width
      @y = y
    else
      puts 'Y coordinate is unavailable'
    end
    if 0 <= x && x <= @area.height
      @x = x
    else
      puts 'X coordinate is unavailable'
    end
    @side = DIRECTION.index(direction) if DIRECTION.include?(direction)
    @alive = true
    puts '-- done'
	end
		
	def move
    if @alive
      case DIRECTION[@side].downcase
        when 'north'
          if @y < @area.height
            @y += 1
          end
        when 'east'
          if @x < @area.width
            @x += 1
          end
        when 'south'
          if @y > 0
            @y -= 1
          end
        when 'west'
          if @x > 0
            @x -= 1
          end
      end
      puts '-- done'
    else
      puts 'PLACE robot first'
    end
  end

  def right
    if @alive
      if @side == DIRECTION.length-1
        @side = 0
      else
        @side += 1
      end
      puts '-- done'
    else
      puts 'PLACE robot first'
    end
  end

  def left
    if @alive
      if @side == 0
        @side = DIRECTION.length-1
      else
        @side -= 1
      end
      puts '-- done'
    else
      puts 'PLACE robot first'
    end
  end

  def report
    puts "-> #{@x}, #{@y}, #{DIRECTION[@side]}"
  end

  def actions(from_keyboard)
    command = from_keyboard.split(' ')
    case command[0].downcase
      when 'place'
        args = command[1].split(',')
        place args[0].to_i, args[1].to_i, args[2]
      when 'move'
        move
      when 'left'
        left
      when 'right'
        right
      when 'report'
        report
    end
  end

end

robot = Robot.new
loop do
  data = gets
  break if data == 'exit'
  robot.actions data
end
