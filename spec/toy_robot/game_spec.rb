# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobot::Game do
  subject(:game) { described_class.new }

  let(:platform) { instance_double(ToyRobot::Platform) }
  let(:robot) { instance_double(ToyRobot::Robot) }

  before do
    allow(ToyRobot::Platform).to receive(:new).and_return(platform)
    allow(ToyRobot::Robot).to receive(:new).and_return(robot)
  end

  describe '#start' do
    it 'prints intro and ends when user types exit' do
      allow(game).to receive(:gets).and_return('exit')

      expect(game).to receive(:print_intro)
      expect(game).to receive(:puts).with("\n👋 Game over!")

      game.start
    end

    it 'handles interrupt (Ctrl+C) gracefully' do
      allow(game).to receive(:print_intro)
      allow(game).to receive(:gets).and_raise(Interrupt)
      allow(game).to receive(:puts).with("\n👋 Game interrupted. Goodbye!")

      game.start
    end
  end

  describe '#handle_command' do
    before { allow(game).to receive(:warn) }

    it 'delegates MOVE to robot' do
      expect(robot).to receive(:move)

      game.send(:handle_command, 'MOVE')
    end

    it 'delegates RIGHT to robot' do
      expect(robot).to receive(:right)

      game.send(:handle_command, 'RIGHT')
    end

    it 'delegates LEFT to robot' do
      expect(robot).to receive(:left)

      game.send(:handle_command, 'LEFT')
    end

    it 'delegates REPORT to robot' do
      expect(robot).to receive(:report)

      game.send(:handle_command, 'REPORT')
    end

    it 'warns on unknown command' do
      expect(game).to receive(:warn).with('❌ Unknown command.')

      game.send(:handle_command, 'JUMP')
    end
  end

  describe '#handle_place' do
    it 'places robot with valid arguments' do
      expect(robot).to receive(:place).with(1, 2, 'NORTH')

      game.send(:handle_place, '1, 2, NORTH')
    end

    it 'warns user in case of incorrect arguments' do
      expect(game).to receive(:warn).with('❌ PLACE requires 3 arguments: X,Y,FACING')

      game.send(:handle_place, '1, 1')
    end
  end
end
