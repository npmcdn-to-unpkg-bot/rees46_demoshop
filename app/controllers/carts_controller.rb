class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :destroy]

  def show
    unless @cart.line_items.present?
      @cart.destroy if @cart.id == session[:cart_id]
      session[:cart_id] = nil
      redirect_to root_path, notice: t('cart.notice_controller')
    end
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to root_path, notice: t('cart.notice_controller')
  end

  def cart_recommender
    @products = []
    unless params[:ids].nil?
      params[:ids].each do |id|
        @products << Product.find(id) if Product.where(id: id).any?
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
