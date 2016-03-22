module ProductsHelper
  def print_stock(stock)
    if stock > 0
      return 'In Stock #{stock}'
    else
      return 'Out of Stock'
    end
  end
end
