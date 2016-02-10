class AddPartTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :part_types, :integer
  end
end
