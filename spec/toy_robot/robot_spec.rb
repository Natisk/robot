# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobot::Robot do
  let(:platform) { instance_double('ToyRobot::Platform') }
  let(:robot) { described_class.new(platform) }

  before do
    allow(platform).to receive(:valid_position?).and_return(true)
  end

  describe '#place' do
    it 'places the robot correctly' do
      expect(robot).to receive(:puts).with('✅ Robot placed at (1, 2) facing NORTH.')
      robot.place(1, 2, 'NORTH')

      expect(robot.x).to eq(1)
      expect(robot.y).to eq(2)
      expect(robot.facing).to eq('NORTH')
      expect(robot).to be_placed
    end

    it 'warns when placement is invalid' do
      allow(platform).to receive(:valid_position?).and_return(false)
      expect(robot).to receive(:warn).with('❌ Invalid placement.')
      robot.place(1, 2, 'NORTH')
      expect(robot).not_to be_placed
    end
  end

  describe '#move' do
    before do
      robot.place(0, 0, 'NORTH')
    end

    it 'moves the robot forward' do
      expect(robot).to receive(:puts).with('🚶 Robot moved to (0, 1).')
      robot.move
      expect(robot.y).to eq(1)
    end

    it 'warns if move is invalid' do
      allow(platform).to receive(:valid_position?).and_return(false)
      expect(robot).to receive(:warn).with('🧱 Move blocked — edge of the platform.')
      robot.move
    end
  end

  describe '#left' do
    before { robot.place(0, 0, 'NORTH') }

    it 'rotates left' do
      expect(robot).to receive(:puts).with('↪️ Turned left. Now facing WEST.')
      robot.left
      expect(robot.facing).to eq('WEST')
    end
  end

  describe '#right' do
    before { robot.place(0, 0, 'NORTH') }

    it 'rotates right' do
      expect(robot).to receive(:puts).with('↩️ Turned right. Now facing EAST.')
      robot.right
      expect(robot.facing).to eq('EAST')
    end
  end

  describe '#report' do
    before { robot.place(2, 3, 'EAST') }

    it 'reports position and facing' do
      expect(robot).to receive(:puts).with('📍 Position: (2, 3), Facing: EAST')
      robot.report
    end
  end
end
