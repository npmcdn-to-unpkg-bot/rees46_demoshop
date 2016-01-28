class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: :create
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    if @line_item.save
      redirect_to @line_item.cart, notice: "Line Item was successfully created."
    else
      render action: 'new'
    end
  end
end
