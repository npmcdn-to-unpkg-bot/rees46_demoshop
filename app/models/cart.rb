class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def total_price
    line_items.to_a.sum(&:total_price)
  end

  def total_quantity
    line_items.to_a.sum(&:total_quantity)
  end

  def product_id_in_cart
    line_items.map {|li| li.product_id }
  end

  def product_price_in_cart
    line_items.select {|li| li.product.price.to_i }
  end

  def category_ids_in_cart
    line_items.select {|li| li.product.category_id }
  end
end
