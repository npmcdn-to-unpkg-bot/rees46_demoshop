class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  validates :size_id, presence: true, if: :nil_sizes?

  def total_price
    product.price * quantity
  end

  private

  def nil_sizes?
    return true if product.size || product.age_sizes? || product.hight_sizes?
    false
  end
end
