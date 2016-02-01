class SetNilDefaultPriceToProducts < ActiveRecord::Migration
  def change
    remove_column :products, :price
    add_column :products, :price, :decimal
  end
end
