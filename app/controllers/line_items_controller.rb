class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: :create
  # before_action :find_line_item, only: :increment, :decrement

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

  # def increment
  #   @line_item.update(quantity: (@line_item.quantity += 1))
  # end
  #
  # def decrement
  #   @line_item.update(quantity: (@line_item.quantity -= 1))
  # end

  private

  # def find_line_item
  #   @line_item = cart.line_items.find(params[:line_item_id])
  # end

  def line_item_params
    params.require(:line_item).permit(:product_id, :size_id, :age_sizes )
  end
end
