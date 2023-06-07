class CocktailRecipe < ApplicationRecord
  belongs_to :category
  belongs_to :container

  has_many :ingredient_measures

  validates :name, presence: true
  validates :instructions, presence: true
  validates :image_url, presence: true

  def self.to_json
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

  def to_json
    {
      id: id,
      name: name,
      category: category.to_s,
      container: container.to_s,
      instructions: instructions,
      image: image_url,
      ingredients: ingredient_measures.map{|im| im.to_json}
    }
  end
end
