class Platform

  attr_reader :width, :height

  def initialize(width_x = 5, height_y = 6)
    @width = width_x
    @height = height_y
  end

end

class Robot

  attr_accessor :x, :y, :direction

  DIRECTION = %w[north east south west]

	def initialize(x = 0, y = 0, direction = 'north')
    @d = DIRECTION.index(direction)
		@y = y
		@x = x
    @side = 0
    @alive = false
    puts 'initialized!!!!!'
	end

	def place(x, y, direction)
    @area = Platform.new(5, 6)
		if y < @area.width.to_s
      @y = y
    else
      puts 'Y is too big'
    end
    if x <= @area.height.to_s
      @x = x
    else
      puts 'X is too big'
    end

    @d = DIRECTION.index(direction)

    @alive = true
    puts 'placed!!!!!!!!'
	end
		
	def move
    if @alive
      case DIRECTION[@side]
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
    end
    puts @area.height
    puts @area.width
    puts 'move!!!!!!!!'
  end

  def right
    if @alive
      if @side == DIRECTION.length
        @side = 0
      else
        @side += 1
      end
    end
    puts 'right'
  end

  def left
    if @alive
      if @side == 0
        @side = DIRECTION[-1]
      else
        @side -= 1
      end
    end
    puts 'hello'
    puts 'left'
  end

  def report
    puts "#{@x}, #{@y}, #{DIRECTION[@side]}"
    puts 'report!!!!!!'
  end

  def actions(from_keyboard)
    command = from_keyboard.split(' ')
    case command[0]
      when 'place'
        args = command[1].split(',')
        self.place args[0], args[1], args[2]
      when 'move'
        self.move
      when 'left'
        self.left
      when 'right'
        self.right
      when 'report'
        self.report
    end
    puts 'actions !!!!!!!!!!!'
  end

end

robot = Robot.new
puts 'Hello World'
loop do
  data = gets
  robot.actions data
  break if gets.eql?('exit')
end
