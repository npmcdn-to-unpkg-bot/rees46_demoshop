class AddRussianSizeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :russian_size, :integer
  end
end
