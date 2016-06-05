class ProductsInfo
  attr_reader :products

  def initialize(line_items)
    @products = []
    @line_items = line_items
  end

  def products_info
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

  def product_ids_in_cart
    @line_items.each do |l|
      product = {}
      product[:cart] = l.product.id
      products << product
    end
    products
  end

  def product_ids_in_cart_line_items
    @line_items.order(:id).each do |cli|
      product = {}
      product[:item_id] = cli.product.id
      product[:price] = cli.product.price
      product[:is_available] = cli.product.available?
      product[:categories] = cli.product.category_id
      products << product
    end
    products[0]
  end
end
