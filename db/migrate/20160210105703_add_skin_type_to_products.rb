class AddSkinTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :skin_type, :integer
  end
end
