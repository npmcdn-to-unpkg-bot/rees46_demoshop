class AddKidsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :kids, :integer
  end
end
