class AddAmericanSizeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :american_size, :integer
  end
end
