class AddSizeArrayToProducts < ActiveRecord::Migration
  def change
    remove_column :products, :russian_size, :integer
    remove_column :products, :euro_size, :integer
    remove_column :products, :british_size, :integer
    remove_column :products, :american_size, :integer
    remove_column :products, :asian_size, :integer
    add_column :products, :russian_sizes, :integer, array: true, null: false, default: []
    add_column :products, :euro_sizes, :integer, array: true, null: false, default: []
    add_column :products, :british_sizes, :integer, array: true, null: false, default: []
    add_column :products, :american_sizes, :integer, array: true, null: false, default: []
    add_column :products, :asian_sizes, :integer, array: true, null: false, default: []
  end
end
