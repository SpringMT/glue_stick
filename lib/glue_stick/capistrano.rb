require 'capistrano/version'
require 'glue_stick'

# rubocop:disable Style/GuardClause
if defined?(Capistrano::VERSION) && Gem::Version.new(Capistrano::VERSION).release >= Gem::Version.new('3.0.0')
  load File.expand_path('../capistrano/tasks/v3/glue_stick.rake', __FILE__)
else
  raise 'Error: grimoiretools requires capistrano v3 or above'
end

module GlueStick
  module Capistrano
  end
end
