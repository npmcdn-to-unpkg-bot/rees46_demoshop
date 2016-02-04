class AddKideToProducts < ActiveRecord::Migration
  def change
    add_column :products, :kide, :integer
  end
end
