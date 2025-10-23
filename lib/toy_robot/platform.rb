# frozen_string_literal: true

module ToyRobot
  # Represents the rectangular platform on which the robot can move.
  # Handles the platform dimensions and checks whether given coordinates
  # are valid positions within its boundaries.
  class Platform
    attr_reader :width, :height

    def initialize(width: 5, height: 5)
      @width  = width
      @height = height
    end

    def valid_position?(x, y)
      (0..width).cover?(x) && (0..height).cover?(y)
    end
  end
end
