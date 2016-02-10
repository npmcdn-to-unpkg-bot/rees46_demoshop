class AddPartTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :part_types, :integer, array: true, null: false, default: []
  end
end
