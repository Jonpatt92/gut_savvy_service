require 'spec_helper'

RSpec.describe FDCService, type: :model do
  it 'food info' do
    json_response = File.read('spec/fixtures/quaker_oats_bar_info.json')

    stub_request(:post, "https://api.nal.usda.gov/fdc/v1/search?api_key=#{ENV['FDC_API_KEY']}")
      .with(body: '{"generalSearchInput":"030000400036"}', headers: { 'Content-Type'=>'application/json' })
      .to_return(status: 200, body: json_response)

    service = FDCService.new
    expected_response = {
      fdcId: 538677,
      description: "BARS",
      dataType: "Branded",
      gtinUpc: "030000400036",
      publishedDate: "2019-04-01",
      brandOwner: "The Quaker Oats Company",
      ingredients: "WHOLE GRAIN ROLLED OATS, SOY CRISP RICE (SOY PROTEIN ISOLATE, RICE STARCH), INVERT SUGAR, BROWN SUGAR, OLIGOFRUCTOSE, RAISINS, PECANS, SUGAR, WATER, POLYDEXTROSE, VEGETABLE SHORTENING (CANOLA OIL, PALM OIL, PALM KERNEL OIL), GLYCERIN, WHOLE OAT FLOUR. CONTAINS 2% OR LESS OF OAT BRAN CONCENTRATE, DRIED WHOLE EGGS, MODIFIED FOOD STARCH, DEXTROSE, CORN SYRUP, NATURAL FLAVOR, FRUCTOSE, MALTED BARLEY EXTRACT, CALCIUM CARBONATE, CINNAMON, SODIUM BICARBONATE, SALT, CORN FLOUR, SODIUM ALGINATE, MALIC ACID, SUNFLOWER OIL, ENZYME MODIFIED SOY PROTEIN, ALMONDS, ALPHA TOCOPHEROL ACETATE (VITAMIN E), NIACINAMIDE (VITAMIN B3), TOCOPHEROLS, SODIUM HEXAMETAPHOSPHATE, VITAMIN A PALMITATE, THIAMIN MONONITRATE (VITAMIN B1), RIBOFLAVIN (VITAMIN B2), PYRIDOXINE HYDROCHLORIDE (VITAMIN B6), CYANOCOBALAMIN (VITAMIN B12). ",
      allHighlightFields: "<b>GTIN/UPC</b>: <em>030000400036</em>",
      score: -747.62915
    }

    expect(service.food_info('030000400036')).to eq(expected_response)
  end
end
