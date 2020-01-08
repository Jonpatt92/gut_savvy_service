require 'faraday'
require 'dotenv/load'

class FDCService
  def food_info(upc)
    @food_info ||= get_food_info(upc)
  end

  def get_food_info(upc)
    response = conn.post('search') do |req|
      req.body = {generalSearchInput: upc}.to_json
    end

    JSON.parse(response.body, symbolize_names: true)[:foods].first

    # raw_food_data = JSON.parse(response.body, symbolize_names: true)
    # raw_food_data[:foods].first if raw_food_data[:foods]
  end

  private

  def conn
    Faraday.new(url: 'https://api.nal.usda.gov/fdc/v1') do |faraday|
      faraday.params['api_key'] = ENV['FDC_API_KEY']
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end
  end
end
