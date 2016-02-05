class Product < ActiveRecord::Base
  INDUSTRY_TYPES = %w[fashion cosmetic kids]
  GENDER_TYPES = %w[unisex male female]
  TYPE_TYPES = %w[shoe shirt tshirt underwear trouser jacket blazer sock belt hat glove]
  SIZE_TYPES = %w[russian_size euro_size american_size british_size asian_size]
  RU_SIZES = %w[35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56]
  EU_SIZES = %w[e36 e37 e38 e39 e40 e41 e42 e43 e44]
  US_SIZES = %w[XS S M L XL XXL]
  UK_SIZES = %w[b3 b4 b5 d5.5  b6 b6.5 b7 b7.5 b8]
  AISA_SIZES = %w[a35 a36 a37 a38 a39 a40 a41 a42 a43 a44 a45 a46 a47 a48 a49 a50 a51 a52 a53 a54 a55 a56]

  enum industry: INDUSTRY_TYPES
  #enum industry: %w[fashion cosmetic kids]
  enum gender: GENDER_TYPES
  enum type: TYPE_TYPES
  enum size: SIZE_TYPES
  enum russian_size: RU_SIZES
  enum euro_size: EU_SIZES
  enum american_size: US_SIZES
  enum british_size: UK_SIZES
  enum asian_size: AISA_SIZES


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
