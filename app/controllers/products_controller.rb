class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :admin_permission, except: [:index, :show]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:notice] = 'сохранил продукт'
      redirect_to products_path
    else
      flash[:error] = 'Не удалось сохранить продукт'
      redner action: new
    end
  end

  def show
    @categories = Category.where(parent_id: nil)
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      flash[:sucess] = 'Продукт был обновлен'
      redirect_to @product
    else
      flash.now[:danger] = 'Продукт не был обновлен'
      render :edit
    end
  end

  def destroy
    return render text: 'Не допускается', status: :forbidden
    @product.destroy
    redirect_to @product
  end

  private

  def admin_permission
    if current_user && current_user.has_role?(:admin)
      return true
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
