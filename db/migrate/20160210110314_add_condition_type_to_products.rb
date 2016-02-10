class AddConditionTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :conditions, :integer, array: true, null: false, default: []
  end
end
