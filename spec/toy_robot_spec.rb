# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ToyRobot do
  it 'has a version number' do
    expect(ToyRobot::VERSION).not_to be_nil
  end

  it 'starts game without errors' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return("report\n", "exit\n")
    expect { ToyRobot.start }.not_to raise_error
  end
end
