class AddChildToProducts < ActiveRecord::Migration
  def change
    add_column :products, :child, :integer
  end
end
