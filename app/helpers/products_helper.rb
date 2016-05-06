module ProductsHelper
  def print_stock(product)
    if product.stock > 0
      link_to('BUY NOW', product_path(product), class: 'btn btn-success')
    end
  end
end
