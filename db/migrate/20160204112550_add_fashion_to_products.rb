class AddFashionToProducts < ActiveRecord::Migration
  def change
    add_column :products, :fashion, :integer
  end
end
