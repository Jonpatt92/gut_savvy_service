ENV['SINATRA_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "development"
ENV['SINATRA_ACTIVESUPPORT_WARNING'] = 'false'

require 'bundler'
Bundler.require(:default, ENV['SINATRA_ENV'])

# Requires all files in app directory (require_all gem)
require_all 'app'
