# require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  ## Contained in config/environment.rb
  # configure do
  #   set :public_folder, 'public'
  #   set :views, 'app/views'
  # end

end
