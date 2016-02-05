class AddBritishSizeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :british_size, :integer
  end
end
