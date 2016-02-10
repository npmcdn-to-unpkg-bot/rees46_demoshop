class AddVolumeIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :volume_id, :integer
  end
end
