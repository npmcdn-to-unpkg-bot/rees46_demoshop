class AddChildSizesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :child_sizes, :integer
  end
end
