class ProductsInfo
  attr_reader :products

  def initialize(line_items)
    @products = []
    @line_items = line_items
  end

  def products_info
    @products.each do |pr|
      if pr.nil?
        product = {}
        product[:item_id] = pr.product.id
        product[:price] = pr.product.price
        product[:is_available] = pr.product.available?
        product[:categories] = pr.product.category_id
        products << product
      end
    end
    products[0]
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
    @line_items.order(:id).select do |cli|
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
