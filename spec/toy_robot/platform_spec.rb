# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobot::Platform do
  subject(:platform) { described_class.new(width: 5, height: 5) }

  describe 'valid_position?' do
    it 'returns true for positions within the bounds' do
      expect(platform.valid_position?(0, 0)).to be true
      expect(platform.valid_position?(5, 5)).to be true
    end

    it 'returns false for positions outside the bounds' do
      expect(platform.valid_position?(-1, 0)).to be false
      expect(platform.valid_position?(0, -1)).to be false
      expect(platform.valid_position?(6, 3)).to be false
    end
  end
end
