class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order('created_at DESC')
  end

  def dashboard
    @orders = Order.order('created_at DESC')
  end
end
