class AddHypoallergenicToProducts < ActiveRecord::Migration
  def change
    add_column :products, :hypoallergenic, :boolean, default: false
  end
end
