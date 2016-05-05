class StoreController < ApplicationController
  def index
    @products = Product.order('created_at DESC')
  end

  def font_products_urls
    @products = []
    params[:ids].each do |id|
      @products << Product.find(id) if Product.where(id: id).any?
    end

    @products = Kaminari.paginate_array(@products).page(params[:page]).per(4)

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
