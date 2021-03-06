class LineItemsController < ApplicationController
  before_action :set_cart
  before_action :find_line_item, only: [:increment, :decrement, :destroy]

  def create
    product = Product.find(line_item_params[:product_id])

    @line_item = @cart.line_items.find_or_initialize_by(line_item_params)
    respond_to do |format|
      format.js do
        if @line_item.persisted?
          @line_item.update(quantity: (@line_item.quantity += 1))
        elsif @line_item.save
        else
          flash[:danger] = ''
        end
      end
    end
  end

  def increment
    respond_to do |format|
      format.js do
        @line_item.update(quantity: (@line_item.quantity += 1))
      end
    end
  end

  def decrement
    respond_to do |format|
      @line_item.update(quantity: (@line_item.quantity -= 1))
      @line_item.destroy if @line_item.quantity == 0
      if !@cart.line_items.any?
        @cart.destroy if @cart.id == session[:cart_id]
        session[:cart_id] = nil
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    if @line_item.destroy
      redirect_to @line_item.cart, notice: t('controller.line_items.destroy.notice')
    else
      redirect_to @line_item.cart, notice: 'Somethign is worng'
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
