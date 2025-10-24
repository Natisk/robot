# frozen_string_literal: true

require_relative 'toy_robot/version'
require_relative 'toy_robot/game'
require_relative 'toy_robot/platform'
require_relative 'toy_robot/robot'

# Main namespace for the ToyRobot gem.
# Provides an entry point to start the interactive robot simulation game.
module ToyRobot
  def self.start
    Game.new.start
  end
end
