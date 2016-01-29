class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

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
    if @product.update_attributes(category_params)
      flash[:sucess] = 'Продукт был обновлен'
      redirect_to @product
    else
      flash.now[:danger] = 'Продукт не был обновлен'
      render :edit
    end
  end

  def destroy
    if @product.user != current_user.has_role?(:admin)
      return render text: 'Не допускается', status: :forbidden
    end
    @product.destroy
    redirect_to @product
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :image, :description, :price, :brand, :category_id)
  end
end
