# frozen_string_literal: true

require_relative "toy_robot/version"
require_relative "toy_robot/game"
require_relative "toy_robot/platform"
require_relative "toy_robot/robot"

module ToyRobot
  def self.start
    Game.new.start
  end
end
