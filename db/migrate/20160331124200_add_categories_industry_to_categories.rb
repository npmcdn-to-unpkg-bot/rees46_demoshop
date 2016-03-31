class AddCategoriesIndustryToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :categories_industry, :integer
  end
end
