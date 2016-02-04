class AddCosmaticToProducts < ActiveRecord::Migration
  def change
    add_column :products, :cosmatic, :integer
  end
end
