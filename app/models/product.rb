class Product < ActiveRecord::Base
  # Main
  INDUSTRY = %w(Fashion Cosmetic Child).freeze
  enum industry: INDUSTRY

  GENDERS = %w(Unisex Male Female).freeze
  enum gender: GENDERS

  ADULT_TYPES = {
    'Shirt'      =>   0,
    'Tshirt'     =>   1,
    'Underwear'  =>   2,
    'Trouser'    =>   3,
    'Jacket'     =>   4,
    'Blazer'     =>   5,
    'Belt'       =>   6,
    'Hat'        =>   7,
    'Glove'      =>   8
  }.freeze

  CHILD_TYPES = {
    'Cloth'      =>   9,
    'Toy'        =>   10,
    'Education'  =>   11,
    'Food'       =>   12,
    'Nappy'      =>   13,
    'Hygiene'    =>   14,
    'Furtiture'  =>   15,
    'School'     =>   16,
    'Transport'  =>   17
  }.freeze

  COMMON_TYPES = {
    'Shoe'       =>   18,
    'Sock'       =>   19
  }.freeze

  TYPES = ADULT_TYPES.merge(CHILD_TYPES).merge(COMMON_TYPES)

  SIZES = {
    'Russian Sizes'      =>   0,
    'Euro Sizes'         =>   1,
    'British Sizes'      =>   2,
    'American Sizes'     =>   3,
    'Asian Sizes'        =>   4,
    'Hight Sizes'  =>   5
  }

  # Child constants class
  AGE_SIZES = {
    "0-3 мес"     => 0,
    "3-6 мес"     => 0.25,
    "6-9 мес"     => 0.5,
    "9-12 мес"    => 0.75,
    "12-18 мес"   => 2,
    "18-24 мес"   => 1.5
  }.freeze

  AGES = {
    'Age less then 2' => 0,
    'Age more than 2' => 1
  }.freeze

  # Consmetic constants class
  PART_TYPES = {
    'Hair' => 0,
    'Face' => 1,
    'Body' => 2,
    'Intim' => 3,
    'Hand' => 4,
    'Leg'  => 5
  }.freeze
  SKIN_TYPES = {
    'Dry'     =>  0,
    'Normal'  =>  1,
    'Oily'    =>  2,
    'Comby'   =>  3
  }.freeze
  CONDITIONS = {
    'Colored'     =>  0,
    'Damaged'     =>  1,
    'Waved'       =>  2,
    'Seborea'     =>  3,
    'Akne'        =>  4,
    'Loss'        =>  5,
    'Grow'        =>  6,
    'Dehydrated'  =>  7,
    'Sensitive'   =>  8,
    'Problem'     =>  9,
    'Fading'      =>  10
  }.freeze

  # BOOLEAN_TYPES Consmetic
  HYPOALLERGENIC = { 'NO' => 0, 'YES' => 1 }.freeze
  PERIODIC = {  'NO' => 0, 'YES' => 1 }.freeze

  RUSSIAN_SIZES = {
    '35' => 0,
    '36' => 1,
    '37' => 2,
    '38' => 3,
    '39' => 4,
    '40' => 5,
    '41' => 6,
    '42' => 7,
    '43' => 8,
    '44' => 9,
    '45' => 10,
    '46' => 11,
    '47' => 12,
    '49' => 13,
    '50' => 14,
    '51' => 15,
    '52' => 16,
    '53' => 17,
    '54' => 18,
    '55' => 19
  }.freeze

  EURO_SIZES = {
    '36' => 0,
    '37' => 1,
    '38' => 2,
    '39' => 3,
    '40' => 4,
    '41' => 5,
    '42' => 6,
    '43' => 7,
    '44' => 8,
    '46' => 9,
    '48' => 10,
    '50' => 11,
    '52' => 12,
    '54' => 13,
    '56' => 14,
    '58' => 15
  }.freeze

  AMERICAN_SIZES = {
    XS: 0,
    S:  1,
    M:  2,
    L:  3,
    XL: 4,
    XXL: 5,
    XXXL: 6
  }.freeze

  BRITISH_SIZES = {
    '3'   => 0,
    '4'   => 1,
    '5'   => 2,
    '5.5' => 3,
    '6'   => 4,
    '6.5' => 5,
    '7'   => 6,
    '7.5' => 7,
    '8'   => 8,
    '9'   => 9,
    '9.5' => 10
  }.freeze

  ASIAN_SIZES = {
    '35' => 0,
    '36' => 1,
    '37' => 2,
    '38' => 3,
    '39' => 4,
    '40' => 5,
    '41' => 6,
    '42' => 7,
    '43' => 8,
    '44' => 9,
    '45' => 10,
    '46' => 11,
    '47' => 12,
    '48' => 13,
    '49' => 14,
    '50' => 15,
    '51' => 16,
    '52' => 17,
    '53' => 18,
    '54' => 19,
    '55' => 20
  }.freeze

  HIGHT_SIZES = {
    'h80-94'    => 0,
    'h95-105'   => 1,
    'h105-115'  => 2,
    'h115-125'  => 3,
    'h125-135'  => 4
  }.freeze

  before_destroy :ensure_not_referenced_by_any_line_item

  mount_uploader :image, ImageUploader

  belongs_to :category
  belongs_to :brand
  has_many :line_items
  has_many :volumes, dependent: :destroy
  accepts_nested_attributes_for :volumes, reject_if: ->(attributes) { attributes['value'].blank? }, allow_destroy: true

  # validates :title, :image, :description, :brand, :category_id, presence: true
  # validates :title, uniqueness: true
  # # Price should be not less then $100 :) lets do some business
  # validates :price, :presence => true, numericality: { greater_than_or_equal_to: 100 }

  def show_product_id?
    if industry == "Fashion"
      true
    elsif industry == "Cosmetic"
      true
    elsif industry == "Child"
      true
    else
      false
    end
  end

  def product_size?
    russian_sizes.present? || euro_sizes.present? || american_sizes.present? || british_sizes.present? || asian_sizes.present?
  end

  def decrement_stock(value)
    reload
    self.stock = stock - value
    fail if stock < 0
    save(validate: false)
  end

  def is_available?
    self.stock > 0 ? 1 : 0
  end

  def gender_type
    if gender == 'Male'
      return 'm'
    else gender == 'Female'
      return 'f'
    end
  end

  def human_available_sizes
    self.send(Product::SIZES.keys[self.size].gsub(' ', '_').downcase).map { |value|
      [
        Product.const_get(Product::SIZES.keys[self.size].gsub(' ', '_').upcase).keys[value],
        value
      ]}
  end

  def human_available_part_types
    self.part_types.map { |pt| Product::PART_TYPES.keys[pt]}
  end

  def human_available_skin_types
    self.skin_types.map { |st| Product::SKIN_TYPES.keys[st]}
  end

  def human_available_conditions
    self.conditions.map { |condition| Product::CONDITIONS.keys[condition]}
  end

  def human_available_child_ages
    self.age_sizes.map {|pas| Product::AGE_SIZES.keys[pas]}
  end

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
