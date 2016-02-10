class AddSkinTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :skin_types, :integer
  end
end
