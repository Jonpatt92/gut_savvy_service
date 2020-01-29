class FoodInfoSerializer
  attr_reader :name, :brand, :upc, :ingredients

  def initialize(food_info)
    @name = food_info[:description]
    @brand = food_info[:brandOwner]
    @upc = food_info[:gtinUpc]
    @ingredients = process_ingredients(food_info[:ingredients]) if food_info[:ingredients]
  end

  def process_ingredients(ingredient_list)
    formatted_ingredients    = format_ingredients(ingredient_list)
    consolidated_ingredients = consolidate_ingredients(formatted_ingredients).uniq.compact
    validate_ingredients(consolidated_ingredients)
  end

  def consolidate_ingredients(ingredients)
    ingredients.map! do |ingredient|
      if ingredient.include?("MILK")
        ingredient.replace("MILK") unless not_dairy_milk?(ingredient)
      elsif ingredient.include?("SALT")
        ingredient.replace("SALT")
      else
        ingredient
      end
    end
  end

  def not_dairy_milk?(ingredient)
    ingredient.include?("ALMOND")  ||
    ingredient.include?("SOY")     ||
    ingredient.include?("CASHEW")  ||
    ingredient.include?("COCONUT") ||
    ingredient.include?("FLAX")    ||
    ingredient.include?("HEMP")    ||
    ingredient.include?("RICE")    ||
    ingredient.include?("OAT")
  end

  def validate_ingredients(ingredients)
      ingredients.delete_if { |ingredient| ingredient.include?("WATER") }
      ingredients.delete_if { |ingredient| ingredient.include?("NATURAL FLAVOR") }
      ingredients.delete_if { |ingredient| ingredient.include?("ARTIFICIAL FLAVOR") }
  end

  def format_ingredients(ingredient_list)
    ingredient_list
      .gsub(/ \[.*?\]/, '')
      .gsub(/ \(.*?\)/, '')
      .gsub(/\(\)\*/, '')
      .gsub('ORGANIC ', '')
      .gsub('100%', '')
      .split('.').first
      .split(', 2%').first
      .split(', CONTAINS').first
      .split(', ')
      .split('AND')
      .flatten
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
