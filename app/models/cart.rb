class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def total_price
    line_items.to_a.sum(&:total_price)
  end

  def total_quantity
    line_items.to_a.sum(&:total_quantity)
  end

  def product_ids_in_cart
    line_items.select {|li| li.product_id }
  end
end
