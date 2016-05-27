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
    @products = Product.where(params[:ids])
    @recommender = params[:recommender]
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end
end
