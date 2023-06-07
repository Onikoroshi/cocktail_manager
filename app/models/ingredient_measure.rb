# Refactor opportunity: extract the Ingredient out to its own table so that it can be queried independantly
class IngredientMeasure < ApplicationRecord
  belongs_to :cocktail_recipe

  validates :name, presence: true
  validates :measurement, presence: true

  # Refactor opportunity: find out why this does not work over in CocktailRecipe when we call `ingredient_measures.to_json` and make it work
  def self.to_json
    self.all.map{ |ingredient_measure| ingredient_measure.to_json }
  end

  def to_json
    {
      name: name,
      measurement: measurement
    }
  end
end
