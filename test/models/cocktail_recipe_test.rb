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

  test "individual to_json only shows proper fields" do
    expected_hash = {
      id: @recipe.id,
      name: @recipe.name,
      category: @recipe.category.to_s,
      container: @recipe.container.to_s,
      instructions: @recipe.instructions,
      image: @recipe.image_url,
      ingredients: @recipe.ingredient_measures.map{|im| im.to_json}
    }

    assert_equal @recipe.to_json, expected_hash
  end

  test "collective to_json only shows proper fields" do
    expected_hash = {
      drinks:
        CocktailRecipe.all.map do |cr|
          {
            id: cr.id,
            name: cr.name.to_s,
            category: cr.category.to_s,
            image: cr.image_url
          }
        end
    }

    assert_equal CocktailRecipe.to_json, expected_hash
  end

  test "using the search function returns the correct results" do
    assert_includes CocktailRecipe.search("van"), cocktail_recipes(:valid)
    refute_includes CocktailRecipe.search("van"), cocktail_recipes(:two)

    assert_includes CocktailRecipe.search("an vL"), cocktail_recipes(:valid)
    assert_includes CocktailRecipe.search("an vL"), cocktail_recipes(:three)
    refute_includes CocktailRecipe.search("an vL"), cocktail_recipes(:two)
  end
end
