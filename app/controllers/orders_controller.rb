class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]

  def index
    if @cart.line_items.empty?
      redirect_to root_path, notice: "Your cart is empty"
      return
    end

    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_form_cart(@cart)

      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        redirect_to root_path, notice: 'Thanks for your Order'
      else
        render :new
      end
  end

  private

    def order_params
      params.require(:order).permit(:name, :address, :email)
    end
end
