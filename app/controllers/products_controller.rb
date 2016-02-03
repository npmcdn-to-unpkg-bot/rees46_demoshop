class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: :show
  before_action :admin_permission, except: :show

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: "Products was saved successfully"
    else
      render :new, notice: "Product was not saved successfully"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to @product, notice: "Product was update successfully"
    else
      render :edit, notice: "Product was not update successfully"
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path, notice: "Product was delete successfully"
    else
      redirect_to products_path, notice: "Ordered Product cant be delete"
    end
  end

  private

  def admin_permission
    if current_user && current_user.has_role?(:admin)
      true
    else
      redirect_to root_path
    end
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :image, :description, :price, :brand, :category_id)
  end
end
