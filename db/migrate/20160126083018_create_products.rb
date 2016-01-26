class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :title
      t.string  :image
      t.text    :description
      t.decimal :price, default: 0.00
      t.string  :brand
      t.integer :category_id

      t.timestamps null: false
    end
    add_index :products, :category_id
  end
end
