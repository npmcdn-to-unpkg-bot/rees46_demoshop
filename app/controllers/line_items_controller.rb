class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :increment, :decrement, :destroy]
  before_action :find_line_item, only: [:increment, :decrement, :destroy]

  def create
    product = Product.find(line_item_params[:product_id])

    @line_item = @cart.line_items.find_or_initialize_by(line_item_params)

    if @line_item.persisted?
      @line_item.update(quantity: (@line_item.quantity += 1))
      redirect_to @line_item.cart
    elsif @line_item.save
      redirect_to @line_item.cart
    else
      flash[:danger] = 'Please select product size !'
      redirect_to product
    end
  end

  def increment
    @line_item.update(quantity: (@line_item.quantity += 1))
    redirect_to @line_item.cart
  end

  def decrement
    @line_item.update(quantity: (@line_item.quantity -= 1))
    redirect_to @line_item.cart
  end

  def destroy
    if @line_item.destroy
      redirect_to @line_item.cart, notice: "Product was successfully remove form line item"
    else
      redirect_to @line_item.cart, notice: "Somethign is worng"
    end
  end

  private

  def find_line_item
    @line_item = @cart.line_items.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:product_id, :size_id, :age_sizes)
  end
end
