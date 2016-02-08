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
    r35: 0,
    r36: 1,
    r37: 2,
    r38: 3,
    r39: 4,
    r40: 5,
    r41: 6,
    r42: 7,
    r43: 8,
    r44: 9,
    r45: 10,
    r46: 11,
    r47: 12,
    r49: 13,
    r50: 14,
    r51: 15,
    r52: 16,
    r53: 17,
    r54: 18,
    r55: 19
  }

  EURO_SIZE = {
    e36: 0,
    e37: 1,
    e38: 2,
    e39: 3,
    e40: 4,
    e41: 5,
    e42: 6,
    e43: 7,
    e44: 8,
    e46: 9,
    e48: 10,
    e50: 11,
    e52: 12,
    e54: 13,
    e56: 14,
    e58: 15
  }

  AMERICAN_SIZE = {
    XS: 0,
    S:  1,
    M:  2,
    L:  3,
    XL: 4,
    XXL: 5
  }

  BRITISH_SIZE = {
    "b3"   => 0,
    "b4"   => 1,
    "b5"   => 2,
    "d5.5" => 3,
    "b6"   => 4,
    "b6.5" => 5,
    "b7"   => 6,
    "b7.5" => 7,
    "b8"   => 8,
    "b9"   => 9,
    "b9.5" => 10
  }

  ASIAN_SIZE = {
    a35: 0,
    a36: 1,
    a37: 2,
    a38: 3,
    a39: 4,
    a40: 5,
    a41: 6,
    a42: 7,
    a43: 8,
    a44: 9,
    a45: 10,
    a46: 11,
    a47: 12,
    a48: 13,
    a49: 14,
    a50: 15,
    a51: 16,
    a52: 17,
    a53: 18,
    a54: 19,
    a55: 20
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
