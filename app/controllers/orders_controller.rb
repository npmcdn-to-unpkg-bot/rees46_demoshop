class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]

  def index
    return (redirect_to root_path, notice: 'Your cart is empty') if @cart.line_items.empty?

    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_form_cart(@cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to root_path, notice: 'Thanks for your Order' }
        format.js
      else
        render :new
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :email)
  end
end
