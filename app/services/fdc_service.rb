require 'faraday'
# require 'dotenv/load'

class FDCService
  def food_info(upc)
    @food_info ||= parse_food_info(upc)
  end

  private

  def parse_food_info(upc)
    return Hash.new unless valid_upc?(upc)

    response = get_food_info(upc)
    raw_food_data = JSON.parse(response.body, symbolize_names: true)

    raw_food_data[:foods].first || Hash.new
  end

  def valid_upc?(upc)
    upc.length == 12 || /\A\d+\z/.match(upc)
  end

  def get_food_info(upc)
    conn.post('search') do |req|
      req.body = {generalSearchInput: upc}.to_json
    end
  end

  def conn
    Faraday.new(url: 'https://api.nal.usda.gov/fdc/v1') do |faraday|
      faraday.params['api_key'] = ENV['FDC_API_KEY']
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
    end
  end
end
