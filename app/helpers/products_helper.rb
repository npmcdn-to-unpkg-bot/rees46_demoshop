module ProductsHelper
  def print_stock(stock)
    stock > 0 ? 'In Stock' : 'Out of Stock'
  end
end
