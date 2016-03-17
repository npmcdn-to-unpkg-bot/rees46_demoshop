class ProductsInfo
  attr_reader :products

  def initialize(line_items)
    @products = []
    @line_items = line_items
  end

  def get_products_info
    @line_items.each do |l|
      product = {}
      product[:item_id] = l.product.id
      product[:price] = l.product.price
      product[:is_available] = 1
      product[:categories] = l.product.category_id
      product[:amount] = 1
      products << product
    end
    products
  end

  def get_cart_products_info
    @line_items.each do |l|
      product = {}
      product[:item_id] = l.product.id
      product[:price] = l.product.price
      product[:is_available] = 1
      product[:categories] = l.product.category_id
      products << product
    end
    products
  end

  def get_similer_products_info
    @line_items.each do |l|
      product = {}
      product[:cart] = l.product.id
      product[:categories] = l.product.category_id
      products << product
    end
    products
  end

  def get_cart_products_ids
    @line_items.map do |li|
      li.product_id
    end
  end

  def get_categories_ids
    @line_items.map do |li|
      li.product.category_id
    end.join(',')
  end
end
