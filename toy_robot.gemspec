# frozen_string_literal: true

require_relative 'lib/toy_robot/version'

Gem::Specification.new do |spec|
  spec.name          = 'toy_robot'
  spec.version       = ToyRobot::VERSION
  spec.authors       = ['Vitalii Matseiko']
  spec.email         = ['realnatisk@gmail.com']

  spec.summary       = 'A console Toy Robot simulator game'
  spec.description   = 'A fun Ruby console game where you control a robot on a grid platform using text commands.'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.7'

  spec.files         = Dir['lib/**/*.rb', 'bin/*', 'README.md']
  spec.bindir        = 'bin'
  spec.executables   = ['toy_robot']
  spec.require_paths = ['lib']

  spec.homepage = 'https://github.com/Natisk/robot'
  spec.metadata['homepage_uri'] = 'https://github.com/Natisk/robot'
end
