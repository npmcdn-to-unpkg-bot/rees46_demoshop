class Product < ActiveRecord::Base
  enum industry: [:fashion, :cosmatic, :kide ]
  enum fashion: [:gender, :type, :size]
  enum gender: [:unisex, :male, :female]
  enum type: [:shoe, :shirt, :tshirt, :underwear, :trouser, :jacket, :blazer, :sock, :belt, :hat, :glove]
  enum size: [:r36, :r38, :r40, :r42, :r44, :r46, :r48, :r50]

  mount_uploader :image, ImageUploader
  belongs_to :category
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :image, :description, :brand, :category_id, presence: true
  validates :title, uniqueness: true
  # Price should be not less then $100 :) lets do some business
  validates :price, :presence => true, numericality: { greater_than_or_equal_to: 100 }
  mount_uploader :image, ImageUploader

  GENDER_TYPES = [["Unisex", "unisex"],["Male", "male"], ["Female", "female"]]

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
