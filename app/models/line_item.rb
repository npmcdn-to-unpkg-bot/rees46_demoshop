class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  validates :size_id, presence: true

  attr_accessor :size_id

  def total_price
    product.price * quantity
  end
end
