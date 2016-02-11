class AddAgesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :ages, :integer, array: true, null: false, default: []
  end
end
