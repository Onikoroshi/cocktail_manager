json.drinks do
  json.id @drink.id
  json.name @drink.name
  json.category @drink.category.to_s
  json.container @drink.container.to_s
  json.instructions @drink.instructions
  json.image @drink.image_url
  json.ingredients @drink.ingredient_measures do |ingredient|
    json.name ingredient.name
    json.measurement ingredient.measurement
  end
end
