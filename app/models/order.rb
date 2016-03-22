class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  validates :name, :address, :email, presence: true

  after_save :decrement_product_stock

  def add_line_items_form_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  private

  def decrement_product_stock
    self.line_items.each do |li|
      binding.pry
      li.product.update(stock: li.product.stock - li.quantity)
    end
  end
end
