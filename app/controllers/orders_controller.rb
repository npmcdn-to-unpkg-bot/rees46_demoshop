class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create, :show]

  def index
    return (redirect_to root_path, notice: 'Your cart is empty') if @cart.line_items.empty?

    @orders = Order.all
  end

  def show
    @line_item = LineItem.all
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

      redirect_to @order, notice: 'Thanks for your Order'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :email)
  end
end
