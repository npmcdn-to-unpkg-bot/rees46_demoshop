class Product < ActiveRecord::Base
  include ProductConstants
  # Main
  enum industry: [:fashion, :cosmetic, :child]

  GENDERS = %w(Unisex Male Female).freeze
  enum gender: GENDERS

  before_destroy :ensure_not_referenced_by_any_line_item

  mount_uploader :image, ImageUploader

  belongs_to :category
  counter_culture :category, foreign_key_values:
      Proc.new {|category_id| [category_id, Category.find_by_id(category_id).try(:parent).try(:id), Category.find_by_id(category_id).try(:parent).try(:parent).try(:id)] }, touch: true
  belongs_to :brand
  has_many :line_items
  has_many :volumes, dependent: :destroy
  accepts_nested_attributes_for :volumes, reject_if: ->(attributes) { attributes['value'].blank? }, allow_destroy: true

  validates :title, :image, :description, :brand, :category_id, presence: true
  validates :title, uniqueness: true
  validates :price, :presence => true, numericality: { greater_than_or_equal_to: 100 }

  def show_product_id?
    if industry == 'fashion'
      true
    elsif industry == 'cosmetic'
      true
    elsif industry == 'child'
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
    raise if stock < 0
    save(validate: false)
  end

  def available?
    stock > 0 ? 1 : 0
  end

  def gender_type
    if gender == 'Male'
      return 'm'
    elsif gender == 'Female'
      return 'f'
    end
  end

  def human_available_sizes
    send(Product::SIZES.keys[size].tr(' ', '_').downcase).map do |value|
      [
        Product.const_get(Product::SIZES.keys[size].tr(' ', '_').upcase).keys[value],
        value
      ]
    end
  end

  def human_available_part_types
    part_types.map { |pt| Product::PART_TYPES.keys[pt] }
  end

  def human_available_british_sizes
    british_sizes.map { |pt| Product::BRITISH_SIZES_PREFIXED.keys[pt] }
  end

  def human_available_euro_sizes
    euro_sizes.map { |pt| Product::EURO_SIZES_PREFIXED.keys[pt] }
  end

  def human_available_skin_types
    skin_types.map { |st| Product::SKIN_TYPES.keys[st] }
  end

  def human_available_conditions
    conditions.map { |condition| Product::CONDITIONS.keys[condition] }
  end

  def human_available_child_ages
    age_sizes.map { |pas| Product::AGE_SIZES.keys[pas] }
  end

  def child_ages_prefixed
    age_sizes.map { |pas| Product::AGE_SIZES_VALUES.keys[pas] }
  end

  def self.redirected_url(page)
    result = Curl::Easy.perform(page) do |curl|
      curl.follow_location = true
    end
    result.last_effective_url
  end

  require 'open-uri'
  require 'net/http'

  def self.remote_image_exists?(url)
    url = URI.parse(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')

    http.start do |http|
      return http.head(url.request_uri)['Content-Type'].start_with? 'image'
    end
  end

  def self.import(doc, category, cat_id, lit_num, stock, gender, p_type, industry, p_size, r_sizes, p_types, s_types, conditions)
    parsed_products = doc.xpath('//offer')

    count = 0
    parsed_products.each do |product|
      next unless product.at_xpath('categoryId').text == cat_id
      product_title = if product.at_xpath('name').nil?
                        nil
                      else
                        product.at_xpath('name').text
                      end

       if remote_image_exists?(URI.extract(URI.encode((product.at_xpath('picture').text.strip)))[0]) == false
         image_link = nil
      else
      image_link = redirected_url(URI.extract(URI.encode(product.at_xpath('picture').text.strip))[0])
       end

      count += 1
      pro_brand = Product.create!(
        title: product_title,
        description: product.at_xpath('description').text,
        price: product.at_xpath('price').text,

        category_id: product.at_xpath('categoryId').text.gsub(cat_id, category),

        remote_image_url: image_link,

        stock: stock,
        gender: gender,
        product_type: p_type,
        industry: industry,
        size: p_size,
        russian_sizes: r_sizes,
        part_types: p_types,
        skin_types: s_types,
        conditions: conditions
      )

      if product.at_xpath('vendor').nil?
        brand = nil
      else
        brand = Brand.find_or_create_by!(name: product.at_xpath('vendor').text)
        pro_brand.update brand_id: brand.id
      end

      if pro_brand.title.nil?
        pro_brand.update title: product.at_xpath('model').text + ' ' + brand.name
      end

      break if count == lit_num.to_i
    end
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
