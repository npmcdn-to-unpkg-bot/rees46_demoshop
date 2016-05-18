class AddCategoryHideToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :category_hide, :integer, default: 0
  end
end
