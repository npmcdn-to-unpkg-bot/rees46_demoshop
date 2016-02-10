class CreateVolumes < ActiveRecord::Migration
  def change
    create_table :volumes do |t|
      t.references :product, index: true, foreign_key: true
      t.integer :value
      t.integer :value_price
      
      t.timestamps null: false
    end
  end
end
