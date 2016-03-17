class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :destroy]

  def show
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to root_path, notice: 'Your cart currently empty.'
  end

  def get_cart_urls
    @products = []
    if params[:ids] != nil
      params[:ids].each do |id|
        if Product.where(id: id).any?
          @products << Product.find(id)
        end
      end
    end

    @recommender = params[:recommender]
    respond_to do |format|
      format.js
    end
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end
end
