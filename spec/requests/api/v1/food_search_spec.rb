require 'spec_helper'

RSpec.describe 'Food Search API Endpoint', type: :request do
  it 'shows the food name, brand, and list of ingredients' do
    json_response = File.read('spec/fixtures/greek_yogurt_info.json')

    stub_request(:post, "https://api.nal.usda.gov/fdc/v1/search?api_key=#{ENV['FDC_API_KEY']}")
      .with(body: '{"generalSearchInput":"818290013613"}', headers: { 'Content-Type'=>'application/json' })
      .to_return(status: 200, body: json_response)

    get '/api/v1/food_search?upc=818290013613'

    expect(last_response).to be_successful

    food_json = JSON.parse(last_response.body)

    expect(food_json['data'].length).to eq(4)
    expect(food_json['data']['name']).to eq('GREEK YOGURT')
    expect(food_json['data']['brand']).to eq('Chobani, Inc.')
    expect(food_json['data']['upc']).to eq('818290013613')
    expect(food_json['data']['ingredients'].length).to eq(10)
    expect(food_json['data']['ingredients'].last).to eq('GUAR GUM')
  end

  # it 'shows an error message if the upc is invalid' do
  #   get '/api/v1/food_search?upc=4253'
  #
  #   expect(response).to be_successful
  #
  #   food_json = JSON.parse(last_response.body)
  #
  #   expect(food_json['errors'].length).to eq(1)
  # end
end
