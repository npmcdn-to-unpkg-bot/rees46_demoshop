class Product < ActiveRecord::Base
  INDUSTRY_TYPES = %w[fashion cosmetic child]

  # Fashion constants class
  GENDER_TYPES = %w[unisex male female]

  TYPE_TYPES = {
    "shirt"      =>   0,
    "tshirt"     =>   1,
    "underwear"  =>   2,
    "trouser"    =>   3,
    "jacket"     =>   4,
    "blazer"     =>   5,
    "belt"       =>   6,
    "hat"        =>   7,
    "glove"      =>   8,
    # child types
    "cloth"      =>   9,
    "toy"        =>   10,
    "education"  =>   11,
    "food"       =>   12,
    "nappy"      =>   13,
    "hygiene"    =>   14,
    "furtiture"  =>   15,
    "school"     =>   16,
    "transport"  =>   17,
    # common types
    "shoe"       =>   18,
    "sock"       =>   19,
  }

  SIZE_TYPES = {
    "russian_sizes"   =>   0,
    "euro_sizes"      =>   1,
    "american_sizes"  =>   2,
    "british_sizes"   =>   3,
    "asian_sizes"     =>   4
  }

  # Consmetic constants class
  PART_TYES = {
    "hair" => 0,
    "face" => 1,
    "body" => 2,
    "intim"=> 3,
    "hand" => 4,
    "leg"  => 5,
  }
  SKIN_TYPES = {
    "dry"     =>  0,
    "normal"  =>  1,
    "oily"    =>  2,
    "comby"   =>  3,
  }
  CONDITIONS = {
    "colored"     =>  0,
    "damaged"     =>  1,
    "waved"       =>  2,
    "seborea"     =>  3,
    "akne"        =>  4,
    "loss"        =>  5,
    "grow"        =>  6,
    "dehydrated"  =>  7,
    "sensitive"   =>  8,
    "problem"     =>  9,
    "fading"      =>  10
  }

  # Child constants class
  AGE = {
    "0"     => 0,
    "0.25"  => 1,
    "0.5"   => 2,
    "0.75"  => 3,
    "1"     => 4,
    "1.5"   => 5
  }

  # BOOLEAN_TYPES Consmetic
  HYPOALLERGENIC = {  "NO" => 0, "YES" => 1}
  PERIODIC = {  "NO" => 0, "YES" => 1 }

  # Main type
  enum industry: INDUSTRY_TYPES

  enum gender: GENDER_TYPES

  RUSSIAN_SIZES = {
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

  EURO_SIZES = {
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

  AMERICAN_SIZES = {
    XS: 0,
    S:  1,
    M:  2,
    L:  3,
    XL: 4,
    XXL: 5,
    XXXL: 6
  }

  BRITISH_SIZES = {
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

  ASIAN_SIZES = {
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
  has_many :volumes, dependent: :destroy
  accepts_nested_attributes_for :volumes, reject_if: lambda {|attributes| attributes['value'].blank?}, :allow_destroy => true

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
