class AddHightSizesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :hight_sizes, :integer, array: true, null: false, default: []
  end
end
