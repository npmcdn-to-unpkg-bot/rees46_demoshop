class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order('created_at DESC')
  end

  def get_popular_urls
    params[:ids] = [128, 129]
    @products = Product.find(params[:ids])
    respond_to do |format|
      format.js
    end
  end

  def dashboard
    @orders = Order.order('created_at DESC')
  end
end
