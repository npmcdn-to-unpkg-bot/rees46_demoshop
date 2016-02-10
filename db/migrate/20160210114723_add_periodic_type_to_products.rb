class AddPeriodicTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :periodic, :integer
  end
end
