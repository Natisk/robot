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
    @y_coord = y
    @x_coord = x
    @side = 0
    @alive = false
    puts 'Robot is complete. Available commands: PLACE x,y,DIRECTION; LEFT; RIGHT; MOVE; REPORT'
  end

  def place(x, y, direction)
    @area = Platform.new
    if 0 <= y && y <= @area.width
      @y_coord = y.to_i
    else
      puts 'Y coordinate is unavailable'
    end
    if 0 <= x && x <= @area.height
      @x_coord = x.to_i
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
          @y_coord += 1 if @y_coord < @area.height
        when 'east'
          @x_coord += 1 if @x_coord < @area.width
        when 'south'
          @y_coord -= 1 if @y_coord > 0
        when 'west'
          @x_coord -= 1 if @x_coord > 0
        else
          puts 'unknown direction'
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
    puts "-> #{@x_coord}, #{@y_coord}, #{DIRECTION[@side]}"
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
      else
        puts 'unknown command'
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