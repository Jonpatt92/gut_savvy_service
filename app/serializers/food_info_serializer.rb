class FoodInfoSerializer
  attr_reader :name, :brand, :upc, :ingredients

  def initialize(food_info)
    @name = food_info[:description]
    @brand = food_info[:brandOwner]
    @upc = food_info[:gtinUpc]
    @ingredients = format_ingredients(food_info[:ingredients])
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
    {
      data: {
        name: name,
        brand: brand,
        upc: upc,
        ingredients: ingredients
      }
    }.to_json
  end
end
