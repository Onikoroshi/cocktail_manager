require "test_helper"

class CocktailRecipeTest < ActiveSupport::TestCase
  def setup
    @recipe = cocktail_recipes(:valid)
  end

  test "name presence is required" do
    assert @recipe.valid?
    assert @recipe.errors.empty?

    @recipe.name = nil
    assert @recipe.invalid?
    assert(@recipe.errors.added?(:name, "can't be blank"), @recipe.errors.full_messages)
  end

  test "category presence is required" do
    assert @recipe.valid?
    assert @recipe.errors.empty?

    @recipe.category = nil
    assert @recipe.invalid?
    assert(@recipe.errors.added?(:category, "must exist"), @recipe.errors.full_messages)
  end

  test "container presence is required" do
    assert @recipe.valid?
    assert @recipe.errors.empty?

    @recipe.container = nil
    assert @recipe.invalid?
    assert(@recipe.errors.added?(:container, "must exist"), @recipe.errors.full_messages)
  end

  test "instructions presence is required" do
    assert @recipe.valid?
    assert @recipe.errors.empty?

    @recipe.instructions = nil
    assert @recipe.invalid?
    assert(@recipe.errors.added?(:instructions, "can't be blank"), @recipe.errors.full_messages)
  end

  test "image_url presence is required" do
    assert @recipe.valid?
    assert @recipe.errors.empty?

    @recipe.image_url = nil
    assert @recipe.invalid?
    assert(@recipe.errors.added?(:image_url, "can't be blank"), @recipe.errors.full_messages)
  end
end
