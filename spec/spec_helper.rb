require_relative './config/environment'
# require 'rspec'
require 'capybara/dsl'
require 'bundler'

ENV["RACK_ENV"] ||= "test"
Bundler.require(:default, ENV["RACK_ENV"])

Capybara.app = ApplicationController

RSpec.configure do |c|
  c.include Capybara::DSL
end
