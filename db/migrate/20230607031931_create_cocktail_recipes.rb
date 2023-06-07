class CreateCocktailRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :cocktail_recipes do |t|
      t.string :name
      t.references :category, null: false, foreign_key: true
      t.references :container, null: false, foreign_key: true
      t.text :instructions
      t.text :image_url

      t.timestamps
    end
  end
end
