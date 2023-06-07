require "test_helper"

class IngredientMeasureTest < ActiveSupport::TestCase
  def setup
    @ingredient = ingredient_measures(:valid)
  end

  test "name presence is required" do
    assert @ingredient.valid?
    assert @ingredient.errors.empty?

    @ingredient.name = nil
    assert @ingredient.invalid?
    assert(@ingredient.errors.added?(:name, "can't be blank"), @ingredient.errors.full_messages)
  end

  test "measurement presence is required" do
    assert @ingredient.valid?
    assert @ingredient.errors.empty?

    @ingredient.measurement = nil
    assert @ingredient.invalid?
    assert(@ingredient.errors.added?(:measurement, "can't be blank"), @ingredient.errors.full_messages)
  end

  test "cocktail_recipe presence is required" do
    assert @ingredient.valid?
    assert @ingredient.errors.empty?

    @ingredient.cocktail_recipe = nil
    assert @ingredient.invalid?
    assert(@ingredient.errors.added?(:cocktail_recipe, "must exist"), @ingredient.errors.full_messages)
  end

  test "individual as_json only shows proper fields" do
    expected_hash = {
      name: @ingredient.name,
      measurement: @ingredient.measurement
    }

    assert_equal @ingredient.as_json, expected_hash
  end

  test "collective as_json only shows proper fields" do
    expected_array = IngredientMeasure.as_json

    assert_equal IngredientMeasure.as_json, expected_array
  end

  test "collective as_json works on individual collections too" do
    recipe = cocktail_recipes(:valid)

    collective = recipe.ingredient_measures.as_json
    using_map = recipe.ingredient_measures.map{|im| im.as_json}

    assert_equal collective, using_map
  end
end
