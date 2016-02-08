class Product < ActiveRecord::Base
  INDUSTRY_TYPES = %w[fashion cosmetic kids]
  GENDER_TYPES = %w[unisex male female]
  TYPE_TYPES = %w[shoe shirt tshirt underwear trouser jacket blazer sock belt hat glove]
  SIZE_TYPES = %w[russian_size euro_size american_size british_size asian_size]

  enum industry: INDUSTRY_TYPES
  enum gender: GENDER_TYPES
  enum type: TYPE_TYPES
  enum size: SIZE_TYPES

  RUSSIAN_SIZE = {
    "35" => 0,
    "36" => 1,
    "37" => 2,
    "38" => 3,
    "39" => 4,
    "40" => 5,
    "41" => 6,
    "42" => 7,
    "43" => 8,
    "44" => 9,
    "45" => 10,
    "46" => 11,
    "47" => 12,
    "49" => 13,
    "50" => 14,
    "51" => 15,
    "52" => 16,
    "53" => 17,
    "54" => 18,
    "55" => 19
  }

  EURO_SIZE = {
    "36" => 0,
    "37" => 1,
    "38" => 2,
    "39" => 3,
    "40" => 4,
    "41" => 5,
    "42" => 6,
    "43" => 7,
    "44" => 8,
    "46" => 9,
    "48" => 10,
    "50" => 11,
    "52" => 12,
    "54" => 13,
    "56" => 14,
    "58" => 15
  }

  AMERICAN_SIZE = {
    XS: 0,
    S:  1,
    M:  2,
    L:  3,
    XL: 4,
    XXL: 5,
    XXX: 6
  }

  BRITISH_SIZE = {
    "3"   => 0,
    "4"   => 1,
    "5"   => 2,
    "5.5" => 3,
    "6"   => 4,
    "6.5" => 5,
    "7"   => 6,
    "7.5" => 7,
    "8"   => 8,
    "9"   => 9,
    "9.5" => 10
  }

  ASIAN_SIZE = {
    "35" => 0,
    "36" => 1,
    "37" => 2,
    "38" => 3,
    "39" => 4,
    "40" => 5,
    "41" => 6,
    "42" => 7,
    "43" => 8,
    "44" => 9,
    "45" => 10,
    "46" => 11,
    "47" => 12,
    "48" => 13,
    "49" => 14,
    "50" => 15,
    "51" => 16,
    "52" => 17,
    "53" => 18,
    "54" => 19,
    "55" => 20
  }

  mount_uploader :image, ImageUploader

  belongs_to :category
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :image, :description, :brand, :category_id, presence: true
  validates :title, uniqueness: true
  # Price should be not less then $100 :) lets do some business
  validates :price, :presence => true, numericality: { greater_than_or_equal_to: 100 }

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
