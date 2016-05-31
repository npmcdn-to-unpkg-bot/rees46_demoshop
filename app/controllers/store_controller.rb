class StoreController < ApplicationController
  def index
    @products = Product.order('created_at DESC')
  end

  def xml_rees46
    @products = Product.all
    @categories = Category.all
  end

  def dashboard
    @orders = Order.order('created_at DESC')
  end
end
