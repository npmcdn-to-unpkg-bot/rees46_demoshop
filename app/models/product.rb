class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :category
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :image, :description, :brand, :category_id, presence: true
  validates :title, uniqueness: true
  # Price should be not less then $100 :) lets do some business 
  validates :price, :presence => true, numericality: { greater_than_or_equal_to: 100 }
  mount_uploader :image, ImageUploader

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
end
