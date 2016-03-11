class BrandsController < ApplicationController
  include CurrentCart
  before_action :find_brand, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :admin_permission, except: :show
  before_action :set_cart

  def index
    @brands = Brand.all
  end

  def show
    @products = @brand.products
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      redirect_to brands_path, notice: "Brand was save successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @brand.update_attributes(brand_params)
      redirect_to brands_path, notice: "Brand was successfully update"
    else
      render :edit
    end
  end

  def destroy
    if @brand.destroy
      redirect_to brands_path, notice: "Brand was successfully remove"
    else
      redirect_to brands_path, notice: "Sorry you dont have permission to delte this"
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

  def find_brand
    @brand = Brand.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit(:name)
  end
end
