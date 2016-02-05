class Product < ActiveRecord::Base
  indus_arr = %w[fashion cosmetic kids].map(&:capitalize)
  fashion_arr = %w[gender type size].map(&:capitalize)
  gender_arr = %w[unisex male female].map(&:capitalize)
  type_arr = %w[shoe shirt tshirt underwear trouser jacket blazer sock belt hat glove].map(&:capitalize)
  size_arr = %w[ru eu us uk az]
  ru_arr = %w[35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56]
  eu_arr = %w[e36 e37 e38 e39 e40 e41 e42 e43 e44]
  us_arr = %w[XS S M L XL XXL]
  uk_arr = %w[b3 b4 b5 d5.5  b6 b6.5 b7 b7.5 b8]
  az_arr = %w[a35 a36 a37 a38 a39 a40 a41 a42 a43 a44 a45 a46 a47 a48 a49 a50 a51 a52 a53 a54 a55 a56]

  enum industry: indus_arr
  enum gender: gender_arr
  enum type: type_arr
  enum size: size_arr
  enum russian_size: ru_arr
  enum euro_size: eu_arr
  enum american_size: us
  enum british_size: uk_arr
  enum asian_size: az_arr


  mount_uploader :image, ImageUploader
  belongs_to :category
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :image, :description, :brand, :category_id, presence: true
  validates :title, uniqueness: true
  # Price should be not less then $100 :) lets do some business
  validates :price, :presence => true, numericality: { greater_than_or_equal_to: 100 }
  mount_uploader :image, ImageUploader

  INDUSTRY_TYPES = indus_arr
  FASHION_TYPEES = fashion_arr
  GENDER_TYPES = gender_arr
  TYPE_TYPES = type_arr
  SIZE_TYPES = [["Russian Size", "ru"], ["Euro Size", "eu"], ["American Size", "us"], ["British Size", "uk"], ["Asian size", "az"]]
  RU_SIZES = ru_arr
  EU_SIZES = eu_arr
  UK_SIZES = uk_arr
  US_SIZES = us_arr
  AISA_SIZES = az_arr

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
