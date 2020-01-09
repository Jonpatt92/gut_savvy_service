require './config/environment'
require 'simplecov'
require 'rack/test'
require 'rspec'
require 'capybara/dsl'
require 'dotenv/load'

SimpleCov.start

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../gut_savvy_app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure { |c| c.include RSpecMixin }
