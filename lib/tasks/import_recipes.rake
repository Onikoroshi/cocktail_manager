namespace :db do
  desc "use the given CSV file to import recipes"
  task :import_recipes_from_csv => :environment do
    ap "importing from csv"

    ap "import successful!"
  end

  desc "use the given JSON file to import recipes"
  task :import_recipes_from_json => :environment do
    ap "importing from json"

    recipe_list = JSON.parse(File.read(Rails.root.join("lib/cocktail_recipes.json")))
    ap "found #{recipe_list.count} recipes!"

    recipe_list.each do |recipe|
      category = Category.find_or_create_by!(name: recipe["category"].downcase)
      container = Container.find_or_create_by!(name: recipe["container"].downcase)

      local_recipe = CocktailRecipe.create!(name: recipe["name"], category: category, container: container, image_url: recipe["image"], instructions: recipe["instructions"])

      recipe["ingredients"].each do |ingredient|
        IngredientMeasure.create!(cocktail_recipe: local_recipe, name: ingredient["name"], measurement: ingredient["measurement"])
      end
    end

    ap "import successful!"
  end
end
