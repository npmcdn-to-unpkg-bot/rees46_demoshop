class Product < ActiveRecord::Base
  # Main
  INDUSTRY = %w[Fashion Cosmetic Child]
  enum industry: INDUSTRY

  GENDERS = %w[Unisex Male Female]
  enum gender: GENDERS

  ADULT_TYPES = {
    "Shirt"      =>   0,
    "Tshirt"     =>   1,
    "Underwear"  =>   2,
    "Trouser"    =>   3,
    "Jacket"     =>   4,
    "Blazer"     =>   5,
    "Belt"       =>   6,
    "Hat"        =>   7,
    "Glove"      =>   8
  }

  CHILD_TYPES = {
    "Cloth"      =>   9,
    "Toy"        =>   10,
    "Education"  =>   11,
    "Food"       =>   12,
    "Nappy"      =>   13,
    "Hygiene"    =>   14,
    "Furtiture"  =>   15,
    "School"     =>   16,
    "Transport"  =>   17
  }

  COMMON_TYPES = {
    "Shoe"       =>   18,
    "Sock"       =>   19
  }

  TYPES = ADULT_TYPES.merge(CHILD_TYPES).merge(COMMON_TYPES)

  SIZES = {
    "Russian Sizes"   =>   0,
    "Euro Sizes"      =>   1,
    "British Sizes"  =>   2,
    "American Sizes"   =>   3,
    "Asian sizes"     =>   4,
    "Hight"           =>   5
  }

  # Child constants class
  CHILD_AGE_SIZES = {
    "0-3 мес"     => 0,
    "3-6 мес"     => 1,
    "6-9 мес"     => 2,
    "9-12 мес"    => 3,
    "12-18 мес"   => 4,
    "18-24 мес"   => 5
  }

  CHILD_HIGHT_SIZES = {
    "h 80-94 CM"    => 0,
    "h 95-105 CM"   => 1,
    "h 105-115 CM"  => 2,
    "h 115-125 CM"  => 3,
    "h 125-135 CM"  => 4
  }

  AGES = {
    "Age less then 2" => 0,
    "Age more than 2" => 1
  }

  # Consmetic constants class
  PART_TYPES = {
    "Hair" => 0,
    "Face" => 1,
    "Body" => 2,
    "Intim"=> 3,
    "Hand" => 4,
    "Leg"  => 5,
  }
  SKIN_TYPES = {
    "Dry"     =>  0,
    "Normal"  =>  1,
    "Oily"    =>  2,
    "Comby"   =>  3,
  }
  CONDITIONS = {
    "Colored"     =>  0,
    "Damaged"     =>  1,
    "Waved"       =>  2,
    "Seborea"     =>  3,
    "Akne"        =>  4,
    "Loss"        =>  5,
    "Grow"        =>  6,
    "Dehydrated"  =>  7,
    "Sensitive"   =>  8,
    "Problem"     =>  9,
    "Fading"      =>  10
  }


  # BOOLEAN_TYPES Consmetic
  HYPOALLERGENIC = {  "NO" => 0, "YES" => 1}
  PERIODIC = {  "NO" => 0, "YES" => 1 }

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
