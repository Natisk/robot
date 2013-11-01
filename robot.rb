class Platform

  attr_reader :width, :height

  def initialize(width_x = 5, height_y = 6)
    @width = width_x
    @height = height_y
  end

end

class Robot

  DIRECTION = %w[NORTH EAST SOUTH WEST]

  def initialize(x = 0, y = 0)
    @y = y
    @x = x
    @side = 0
    @alive = false
    puts 'Robot is complete'
  end

  def place(x, y, direction)
    @area = Platform.new
    if 0 <= y && y <= @area.width
      @y = y.to_i
    else
      puts 'Y coordinate is unavailable'
    end
    if 0 <= x && x <= @area.height
      @x = x.to_i
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
          @y += 1 if @y < @area.height
        when 'east'
          @x += 1 if @x < @area.width
        when 'south'
          @y -= 1 if @y > 0
        when 'west'
          @x -= 1 if @x > 0
      end
      puts '-- done'
    else
      puts 'PLACE robot first'
    end
  end

  def right
    if @alive
      @side = @side == DIRECTION.length-1 ? 0 : @side += 1
      puts '-- done'
    else
      puts 'PLACE robot first'
    end
  end

  def left
    if @alive
      @side = @side == 0 ? DIRECTION.length-1 : @side -= 1
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
        place args[0].to_i, args[1].to_i, args[2].upcase
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
  data = gets.chomp
  break if data.eql? 'exit'
  robot.actions data
end

#%{PLACE 0,0,NORTH;MOVE;REPORT;PLACE 0,0,NORTH;LEFT;REPORT;PLACE 1,2,EAST;MOVE;MOVE;LEFT;MOVE;REPORT;}.split(';').each do |command|
#  robot.actions command
#end
