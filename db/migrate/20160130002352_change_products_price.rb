class ChangeProductsPrice < ActiveRecord::Migration
  def up
    change_table :products do |t|
      t.change :price, :decimal, precision: 8, scale: 2
    end
  end

  def down
    change_table :products do |t|
      t.change :price, :decimal, default: 0.00
    end
  end
end
