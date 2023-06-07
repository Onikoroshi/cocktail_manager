class CocktailRecipe < ApplicationRecord
  belongs_to :category
  belongs_to :container

  has_many :ingredient_measures

  validates :name, presence: true
  validates :instructions, presence: true
  validates :image_url, presence: true

  scope :search, ->(search_value) { where("cocktail_recipes.name ILIKE '%#{search_value}%'") }

  def self.as_json(options = {})
    {
      drinks: self.all.map do |cocktail_recipe|
        {
          id: cocktail_recipe.id,
          name: cocktail_recipe.name.to_s,
          category: cocktail_recipe.category.to_s,
          image: cocktail_recipe.image_url
        }
      end
    }
  end

  def as_json(options = {})
    {
      drinks: [
        id: id,
        name: name,
        category: category.to_s,
        container: container.to_s,
        instructions: instructions,
        image: image_url,
        ingredients: ingredient_measures.as_json(options)
      ]
    }
  end
end
