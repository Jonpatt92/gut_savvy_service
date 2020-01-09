class FoodInfoSerializer
  attr_reader :name, :brand, :upc, :ingredients

  def initialize(food_info)
    @name = food_info[:description]
    @brand = food_info[:brandOwner]
    @upc = food_info[:gtinUpc]
    @ingredients = format_ingredients(food_info[:ingredients]) if food_info[:ingredients]
  end

  def format_ingredients(ingredient_list)
    ingredient_list
      .gsub(/ \[.*?\]/, '')
      .gsub(/ \(.*?\)/, '')
      .split('.').first
      .split(', 2%').first
      .split(', CONTAINS').first
      .split(', ')
  end

  def format_json
    if ingredients
      data_hash
    else
      error_hash
    end
  end

  private

  def data_hash
    {
      data: {
        name: name,
        brand: brand,
        upc: upc,
        ingredients: ingredients
      }
    }.to_json
  end

  def error_hash
    {
      errors: [{
        status: '404 Not Found',
        title: 'Invalid UPC Code. Please try again.'
      }]
    }.to_json
  end
end
