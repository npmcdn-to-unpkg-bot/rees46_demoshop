class AddSizeArrayToProducts < ActiveRecord::Migration
  def change
    remove_column :products, :russian_size, :integer
    remove_column :products, :euro_size, :integer
    remove_column :products, :british_size, :integer
    remove_column :products, :american_size, :integer
    remove_column :products, :asian_size, :integer
    add_column :products, :russian_size, :integer, array: true
    add_column :products, :euro_size, :integer, array: true
    add_column :products, :british_size, :integer, array: true
    add_column :products, :american_size, :integer, array: true
    add_column :products, :asian_size, :integer, array: true
  end
end
