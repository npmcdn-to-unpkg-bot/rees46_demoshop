module ProductsHelper
  def print_stock(stock)
    if stock > 0
      return 'In Stock'
    else
      return 'Out of Stock'
    end
  end
end
