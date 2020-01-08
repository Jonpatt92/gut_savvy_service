require './config/environment'
require 'simplecov'
require 'rack/test'
require 'rspec'
require 'capybara/dsl'
require 'vcr'

SimpleCov.start

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../gut_savvy_app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

# For RSpec 2.x and 3.x
RSpec.configure { |c| c.include RSpecMixin }

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data("<ENV['FDC_API_KEY']>") { ENV['FDC_API_KEY'] }
end
