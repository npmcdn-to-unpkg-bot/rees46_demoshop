class RemoveProductCountToCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :product_count, :integer, default: 0
  end
end
