class CocktailRecipe < ApplicationRecord
  belongs_to :category
  belongs_to :container

  has_many :ingredient_measures

  validates :name, presence: true
  validates :instructions, presence: true
  validates :image_url, presence: true
end
