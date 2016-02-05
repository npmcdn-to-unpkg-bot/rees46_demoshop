class Product < ActiveRecord::Base
  enum industry: [:fashion, :cosmetic, :kids ]
  enum gender: [:unisex, :male, :female]
  enum type: [:shoe, :shirt, :tshirt, :underwear, :trouser, :jacket, :blazer, :sock, :belt, :hat, :glove]
  enum size: [:ru, :eu, :us, :bz, :az]
  enum russian_size: [:r36, :r38, :r40, :r42, :r44, :r46, :r48, :r50, :r52]
  enum euro_size: [:e36, :e37, :e38, :e39, :e40, :e41, :e42, :e43, :e44]
  enum american_size: [:XS, :S, :M, :L, :XL, :XXL]
  # enum british_size: [:B3, :B3.5, :B4, :B4.5, :B5, :B5.5 ]
  enum asia_size: [:a35, :a36, :a37, :a38, :a39, :a40, :a41, :a42]


  mount_uploader :image, ImageUploader
  belongs_to :category
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :image, :description, :brand, :category_id, presence: true
  validates :title, uniqueness: true
  # Price should be not less then $100 :) lets do some business
  validates :price, :presence => true, numericality: { greater_than_or_equal_to: 100 }
  mount_uploader :image, ImageUploader

  INDUSTRY_TYPES = [["Fashion", "fashion"], ["Cosmetic", "cosmetic"], ["Kids", "kids"]]

  FASHION_TYPEES = [["Gender", "gender"], ["Type", "type"], ["Size", "size"]]

  GENDER_TYPES = [["Unisex", "unisex"],["Male", "male"], ["Female", "female"]]

  TYPE_TYPES = [["Shoe", "shoe"], ["Shirt", "shirt"], ["Tshirt", "tshirt"], ["Underwear", "underwear"], ["Trouser", "trouser"], ["Jacket", "jacket"], ["Blazer", "blazer"], ["Sock", "sock"], ["Belt", "belt"], ["Hat", "hat"], ["Glove", "glove"]]

  SIZE_TYPES = [["Russian Size", "ru"], ["EURO Size", "eu"], ["American Size", "us"], ["British Size", "bz"] ["Asian size", "az"]]

  RU_SIZES = [["R36", "r36"], ["R38", "r38"], ["R40", "r40"], ["R42", "r42"], ["R44", "r44"], ["R46", "r46"], ["R48", "r48"], ["R50", "r50"]]

  EU_SIZES = []

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
