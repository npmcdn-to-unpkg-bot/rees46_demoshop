class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :admin_permission, except: [:index, :show]

  def index
    @category = nil
    @categories = Category.where(parent_id: nil)
  end

  def show
    @products = @category.products
  end

  def new
    @category = Category.new
    @category = Category.find(params[:id]) unless params[:id].nil?
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'сохранил категорию'
      redirect_to categories_path
    else
      flash.now[:error] = 'Не удалось сохранить категорию'
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      flash[:sucess] = 'Категория был обновлен'
      redirect_to categories_path
    else
      flash.now[:danger] = 'Категория не был обновлен'
      render :edit
    end
  end

  def destroy
    if @category.user != current_user.has_role?(:admin)
      return render text: 'Не допускается', status: :forbidden
    end
    @category.destroy
    redirect_to @category
  end

  private

  def admin_permission
    if current_user && current_user.has_role?(:admin)
      return true
    else
      redirect_to root_path
    end
  end

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end
