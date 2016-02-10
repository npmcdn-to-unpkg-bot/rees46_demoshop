class AddPartTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :part_type, :integer
  end
end
