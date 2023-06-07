# Refactor opportunity: extract the Ingredient out to its own table so that it can be queried independantly
class IngredientMeasure < ApplicationRecord
  belongs_to :cocktail_recipe

  validates :name, presence: true
  validates :measurement, presence: true
end
