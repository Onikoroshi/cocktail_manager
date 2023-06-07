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
end
