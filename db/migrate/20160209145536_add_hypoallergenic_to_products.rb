class AddHypoallergenicToProducts < ActiveRecord::Migration
  def change
    add_column :products, :hypoallergenic, :integer, default: false
  end
end
