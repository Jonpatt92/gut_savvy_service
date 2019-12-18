require 'bundler'
Bundler.require

require_relative './config/environment'
require_relative './app/controllers/application_controller'

run ApplicationController
