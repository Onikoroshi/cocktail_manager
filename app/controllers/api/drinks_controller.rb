class Api::DrinksController < ApplicationController
  def search
    index = params[:index] || 0
    limit = params[:limit] || 10
    search_value = params[:query]

    if search_value.blank?
      render json: { drinks: [] }
    else
      @drinks = CocktailRecipe.search(search_value).offset(index).limit(limit).includes(:category)
      render json: { count: @drinks.count, drinks: @drinks.map{|drink| drink.collective_json} }
    end
  end

  def detail
    @drink = CocktailRecipe.find(params[:id])

    render json: @drink.individual_json
  end
end
