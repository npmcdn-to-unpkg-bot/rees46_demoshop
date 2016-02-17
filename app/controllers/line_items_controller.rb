class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: :create

  def create
    product = Product.find(line_item_params[:product_id])
    # @line_item = @cart.add_product(line_item_params)
    @line_item = @cart.line_items.create(line_item_params)

    if @line_item.save
      redirect_to @line_item.cart
    else
      flash[:danger] = 'Please select product size !'
      redirect_to product
    end
  end

  private

  def line_item_params
    #binding.pry
    params.require(:line_item).permit(:product_id, :size_id, :age_sizes )
  end
end
