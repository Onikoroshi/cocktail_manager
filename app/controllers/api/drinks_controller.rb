class Api::DrinksController < ApplicationController
  def search
    index = params[:index] || 0
    limit = params[:limit] || 10
    search_value = params[:query]

    if search_value.blank?
      @drinks = []
    else
      @drinks = CocktailRecipe.search(search_value).offset(index).limit(limit).includes(:category)
    end
  end

  def detail
    @drink = CocktailRecipe.find(params[:id])
  end
end
