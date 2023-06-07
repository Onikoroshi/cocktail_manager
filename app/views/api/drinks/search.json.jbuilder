json.drinks @drinks do |drink|
  json.id drink.id
  json.name drink.name
  json.category drink.category.to_s
  json.image drink.image_url
end
