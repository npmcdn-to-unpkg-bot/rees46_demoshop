class AddHypoallergenicToProducts < ActiveRecord::Migration
  def change
    add_column :products, :hypoallergenic, :integer
  end
end
