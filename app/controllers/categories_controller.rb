class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :cat_urls]
  before_action :admin_permission, except: [:show, :cat_urls]

  def index
    @categories = Category.where(parent_id: nil)
  end

  def show
    @categories = Category.all

    @products = @category.products.page(params[:page])
    if !@category.root?
      @products = Product.page(params[:page]).per(24)
    else @category.root?
      @products = Product.page(params[:page])
    end
    @categories = Category.where(parent_id: @category).page(params[:page])
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

  def cat_urls
    @products = []
    params[:ids].each do |id|
      @products << Product.find(id) if Product.where(id: id).any?
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
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :parent_id, :categories_industry, :slug)
  end
end
