class AddAsianSizeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :asian_size, :integer
  end
end
