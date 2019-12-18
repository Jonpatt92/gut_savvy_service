ENV['SINATRA_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "development"
# Sinatra active-support is a dependent of sinatra-contrib which is not being used.
# This is raising an error that activesupport is not being loaded to hash before sinatra::base
ENV['SINATRA_ACTIVESUPPORT_WARNING'] = 'false'

require 'bundler'
Bundler.require(:default, ENV['SINATRA_ENV'])


# get the path of the root of the app
# APP_ROOT = File.expand_path("..", __dir__)

# require the controller(s)
# Dir.glob(File.join(APP_ROOT, 'app', 'controllers', '*.rb')).each { |file| require file }

# require the model(s)
# Dir.glob(File.join(APP_ROOT, 'app', 'models', '*.rb')).each { |file| require file }

# require database configurations
# require File.join(APP_ROOT, 'config', 'database')

# Requires all files in app directory (require_all gem)
require_all 'app'

# Requires database configurations (require_all gem)
require_rel 'database'

# configure ApplicationController settings
class ApplicationController < Sinatra::Base
  set :method_override, true
  set :views, 'app/views'
  set :public_folder, 'public'
  # set :root, APP_ROOT
end
