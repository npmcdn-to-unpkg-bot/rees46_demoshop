class AddCosmeticToProducts < ActiveRecord::Migration
  def change
    add_column :products, :cosmetic, :integer
  end
end
