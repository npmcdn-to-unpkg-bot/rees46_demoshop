class StoreController < ApplicationController
  def index
    @products = Product.order('created_at DESC')
  end

  def store_recommender
    @products = []
    params[:ids].each do |id|
      @products << Product.find(id) if Product.where(id: id).any?
    end

    @recommender = params[:recommender]
    respond_to do |format|
      format.js
    end
  end

  def xml_rees46
    @products = Product.all
    @categories = Category.all
  end

  def dashboard
    @orders = Order.order('created_at DESC')
  end
end
