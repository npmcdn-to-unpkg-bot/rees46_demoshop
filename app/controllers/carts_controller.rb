class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :destroy]

  def index
    @carts = Cart.all
  end

  def show
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to root_path, notice: 'Cart currently empty.'
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end
end
