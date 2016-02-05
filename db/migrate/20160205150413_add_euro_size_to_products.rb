class AddEuroSizeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :euro_size, :integer
  end
end
