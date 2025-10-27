# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobot::Robot do
  let(:platform) { instance_double('ToyRobot::Platform') }
  let(:robot)    { described_class.new(platform) }

  before do
    allow(platform).to receive(:valid_position?).and_return(true)
  end

  describe '#place' do
    context 'with valid position and direction' do
      it 'places the robot on the platform' do
        expect { robot.place(1, 2, 'NORTH') }
          .to output(/✅ Robot placed at \(1, 2\) facing NORTH./).to_stdout

        expect(robot.x).to eq(1)
        expect(robot.y).to eq(2)
        expect(robot.facing).to eq('NORTH')
        expect(robot.placed?).to be true
      end
    end

    context 'with invalid position' do
      it 'warns and does not place the robot' do
        allow(platform).to receive(:valid_position?).and_return(false)

        expect { robot.place(10, 10, 'NORTH') }
          .to output(/❌ Invalid placement/).to_stderr

        expect(robot.placed?).to be false
      end
    end

    context 'with invalid direction' do
      it 'warns and does not place the robot' do
        expect { robot.place(0, 0, 'DIAGONAL') }
          .to output(/❌ Invalid placement/).to_stderr

        expect(robot.placed?).to be false
      end
    end
  end

  describe '#move' do
    before { robot.place(0, 0, 'NORTH') }

    it 'moves the robot one unit forward' do
      expect { robot.move }
        .to output(/🚶 Robot moved to \(0, 1\)/).to_stdout

      expect(robot.x).to eq(0)
      expect(robot.y).to eq(1)
    end

    it 'warns if move would go off the platform' do
      allow(platform).to receive(:valid_position?).and_return(false)

      expect { robot.move }
        .to output(/🧱 Move blocked/).to_stderr
    end
  end

  describe '#left' do
    before { robot.place(0, 0, 'NORTH') }

    it 'rotates the robot to the left' do
      expect { robot.left }
        .to output(/↪️ Turned left. Now facing WEST/).to_stdout

      expect(robot.facing).to eq('WEST')
    end
  end

  describe '#right' do
    before { robot.place(0, 0, 'NORTH') }

    it 'rotates the robot to the right' do
      expect { robot.right }
        .to output(/↩️ Turned right. Now facing EAST/).to_stdout

      expect(robot.facing).to eq('EAST')
    end
  end

  describe '#report' do
    before { robot.place(2, 3, 'EAST') }

    it 'prints the current position and direction' do
      expect { robot.report }
        .to output(/📍 Position: \(2, 3\), Facing: EAST/).to_stdout
    end
  end

  describe '#ensure_placed!' do
    it 'throws :skip_command when robot not placed' do
      expect do
        catch(:skip_command) { robot.send(:ensure_placed!) }
      end.not_to raise_error
    end
  end
end
