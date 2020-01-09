require 'sinatra'
require 'bundler'
Bundler.require

require_relative './config/environment'
require './gut_savvy_app'

run GutSavvyApp.new
