class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :category
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, presence: true
  validates :image, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :brand, presence: true
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
