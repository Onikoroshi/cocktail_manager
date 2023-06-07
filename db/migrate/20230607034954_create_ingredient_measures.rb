class CreateIngredientMeasures < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredient_measures do |t|
      t.string :name
      t.string :measurement
      t.references :cocktail_recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
