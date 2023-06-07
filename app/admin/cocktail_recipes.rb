ActiveAdmin.register CocktailRecipe do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :category_id, :container_id, :instructions, :image_url
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :category_id, :container_id, :instructions, :image_url]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  show do
    attributes_table do
      row :name
      row :category
      row :container
      row :instructions
      row :image_url do |recipe|
        image_tag recipe.image_url
      end
      row :created_at
      row :updated_at
    end

    ul do
      cocktail_recipe.ingredient_measures.find_each do |ingredient|
        li "#{ingredient.name} -> #{ingredient.measurement}"
      end
    end

    active_admin_comments
  end
end
