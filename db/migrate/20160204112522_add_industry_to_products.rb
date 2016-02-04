class AddIndustryToProducts < ActiveRecord::Migration
  def change
    add_column :products, :industry, :integer
  end
end
