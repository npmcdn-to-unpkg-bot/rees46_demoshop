class AddChildAgesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :child_ages, :integer
  end
end
