class Container < ApplicationRecord
  include NormalizedName

  has_many :cocktail_recipes
end
