class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order('created_at DESC')
  end

  def get_popular_urls
    @products = []
    params[:ids].each do |id|
      if Product.where(id: id).any?
        @products << Product.find(id)
      end
    end

    @recommender = params[:recommender]
    respond_to do |format|
      format.js
    end
  end

  def dashboard
    @orders = Order.order('created_at DESC')
  end
end
