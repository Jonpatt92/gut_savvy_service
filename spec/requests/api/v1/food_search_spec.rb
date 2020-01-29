require 'spec_helper'

RSpec.describe 'Food Search API Endpoint', type: :request do
  def app
    GutSavvyApp
  end

  it 'shows the food name, brand, and list of ingredients' do
    get '/api/v1/food_search?upc=818290013613'

    expect(last_response).to be_successful

    food_json = JSON.parse(last_response.body)

    expect(food_json['data'].length).to eq(4)
    expect(food_json['data']['name']).to eq('GREEK YOGURT')
    expect(food_json['data']['brand']).to eq('Chobani, Inc.')
    expect(food_json['data']['upc']).to eq('818290013613')
    expect(food_json['data']['ingredients'].length).to eq(9)
    expect(food_json['data']['ingredients'].last).to eq('GUAR GUM')
  end

  it 'shows an error message if the upc is not 12 digits' do
    get '/api/v1/food_search?upc=4253'

    expect(last_response).to be_successful

    food_json = JSON.parse(last_response.body)

    expect(food_json['errors'].length).to eq(1)
    expect(food_json['errors'][0]['status']).to eq('404 Not Found')
    expect(food_json['errors'][0]['title']).to eq('Invalid UPC Code. Please try again.')
  end

  it 'shows an error message if the upc includes letters' do
    get '/api/v1/food_search?upc=chocolatepie'

    expect(last_response).to be_successful

    food_json = JSON.parse(last_response.body)

    expect(food_json['errors'].length).to eq(1)
    expect(food_json['errors'][0]['status']).to eq('404 Not Found')
    expect(food_json['errors'][0]['title']).to eq('Invalid UPC Code. Please try again.')
  end
end
