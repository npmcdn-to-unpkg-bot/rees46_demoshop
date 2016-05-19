class RemoveAncestryToCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :ancestry, :string
  end
end
