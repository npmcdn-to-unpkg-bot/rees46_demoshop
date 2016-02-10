class AddConditionTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :conditions, :integer
  end
end
