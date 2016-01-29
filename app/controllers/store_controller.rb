class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
  end

  def dashboard
  end
end
