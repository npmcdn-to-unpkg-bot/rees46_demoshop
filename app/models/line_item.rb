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
     #binding.pry
    if self.product.size?
      true
    elsif self.product.size
      true
    elsif self.product.age_sizes?
      true
    elsif self.product.hight_sizes?
      true
    elsif self.product.part_types?
      false
    else
      false
    end
  end
end
