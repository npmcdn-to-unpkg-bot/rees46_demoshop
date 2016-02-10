class Product < ActiveRecord::Base
  INDUSTRY_TYPES = %w[fashion cosmetic kids]

  # Fashion constants class
  GENDER_TYPES = %w[unisex male female]
  TYPE_TYPES = %w[shoe shirt tshirt underwear trouser jacket blazer sock belt hat glove]
  SIZE_TYPES = %w[russian_size euro_size american_size british_size asian_size]

  # Consmetic constants class
  COSMETIC_GENDER_TYPES = %w[unisex male female]
  
  PART_TYES = {
    "hair" => 0,
    "face" => 1,
    "body" => 2,
    "intim"=> 3,
    "hand" => 4,
    "leg"  => 5,
  }
  SKIN_TYPES = %w[dry normal oily comby]
  CONDITIONS = %w[colored damaged waved seborea akne
  loss grow dehydrated sensitive problem fading]
  VOLUMES = %w[value price]


  # BOOLEAN_TYPES
  HYPOALLERGENIC = { "YES" => 1, "NO" => 0}
  # PERIODICS = BOOLEAN

  # Main type
  enum industry: INDUSTRY_TYPES


  enum gender: GENDER_TYPES

  # Fashion enum
  enum type: TYPE_TYPES
  enum size: SIZE_TYPES

  # Cosmetic enum
  #enum consmetic_gender: COSMETIC_GENDER_TYPES

  # Cosmetic
  HAIR_TYPES = {}
  FACE_TYPES = {}
  BODY_TYPES = {}
  INTIM_TYPES = {}
  HAND_TYPES = {}


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
    XXXL: 6
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

  # validates :title, :image, :description, :brand, :category_id, presence: true
  # validates :title, uniqueness: true
  # # Price should be not less then $100 :) lets do some business
  # validates :price, :presence => true, numericality: { greater_than_or_equal_to: 100 }

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
