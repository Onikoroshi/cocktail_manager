# Refactor opportunity: extract the Ingredient out to its own table so that it can be queried independantly
class IngredientMeasure < ApplicationRecord
  belongs_to :cocktail_recipe

  validates :name, presence: true
  validates :measurement, presence: true

  def self.as_json(options = {})
    self.all.map{ |ingredient_measure| ingredient_measure.as_json }
  end

  def as_json(options = {})
    {
      name: name,
      measurement: measurement
    }
  end
end
