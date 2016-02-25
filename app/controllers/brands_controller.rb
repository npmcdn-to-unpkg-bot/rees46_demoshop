class BrandsController < ApplicationController
  def index
    @drands = Brand.all
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

  def find_brand
    @brand = Brand.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit(:name)
  end
end
