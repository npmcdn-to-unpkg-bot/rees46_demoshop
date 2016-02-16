class StoreController < ApplicationController
  def index
    @products = Product.order('created_at DESC')
  end

  def dashboard
    @orders = Order.order('created_at DESC')
  end
end
