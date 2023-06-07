# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        ul do
          li link_to("Categories", admin_categories_path)
          li link_to("Containers", admin_containers_path)
          li link_to("Ingredient Measurements", admin_ingredient_measures_path)
          li link_to("Cocktail Recipes", admin_cocktail_recipes_path)
        end
      end
    end
  end # content
end
