class AddAgeSizesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :age_sizes, :integer, array: true, null: false, default: []
  end
end
