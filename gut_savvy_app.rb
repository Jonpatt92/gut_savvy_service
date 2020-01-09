require 'sinatra'
require_relative 'app/services/fdc_service.rb'
require_relative 'app/serializers/food_info_serializer.rb'

class GutSavvyApp < Sinatra::Base
  get '/api/v1/food_search' do
    content_type :json
    service = FDCService.new
    food_info = service.food_info(params[:upc])
    serialized_food_info = FoodInfoSerializer.new(food_info)
    serialized_food_info.format_json
  end
end
