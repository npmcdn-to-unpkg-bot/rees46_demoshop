class AddGenderToProducts < ActiveRecord::Migration
  def change
    add_column :products, :gender, :integer
  end
end
