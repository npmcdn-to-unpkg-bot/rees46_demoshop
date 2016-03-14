class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :get_urls]
  before_action :admin_permission, except: [:show, :get_urls]

  def index
    @categories = Category.where(parent_id: nil)
  end

  def show
    @products = @category.products
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: 'Category was saved successfully'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      redirect_to categories_path, notice: 'Category was update successfully'
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to @category, notice: 'Category was delete successfully'
    else
      redirect_to root_path, notice: 'You dont have permission to delete this'
    end
  end

  def get_urls
    @products = []
    params[:ids].each do |id|
      if Product.where(id: id).any?
        @products << Product.find(id)
      end
    end

    @recommender = params[:recommender]
    respond_to do |format|
      format.js
    end
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
