class BrandsController < ApplicationController
  before_action :find_brand, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :admin_permission, except: :show

  def index
    @brands = Brand.order('name ASC').group_by { |u| u.name[0] }
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
      redirect_to brands_path, notice: t('controller.brands.create.notice')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @brand.update_attributes(brand_params)
      redirect_to brands_path, notice: t('controller.brands.update.notice')
    else
      render :edit
    end
  end

  def destroy
    if @brand.destroy
      redirect_to brands_path, notice: t('controlle.brands.destroy.notice.destroy')
    else
      redirect_to brands_path, notice: t('controlle.brands.destroy.notice_brands_path')
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
