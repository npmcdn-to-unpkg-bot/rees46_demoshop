class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :products_recommender]
  before_action :admin_permission, except: [:show, :products_recommender]

  def index
    @products = Product.order('created_at DESC').page(params[:page]).per(15)
    @category = Category.all
  end

  def new
    @product = Product.new
    @product.volumes.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: t('controller.products.create.notice')
    else
      render :new, notice: t('controller.products.create.notice_new')
    end
  end

  def show
    @line_item = LineItem.new
    @category = @product.category
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to @product, notice: t('controller.products.update.notice')
    else
      render :edit, notice: t('controller.products.update.notice_edit')
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path, notice: t(controller.products.destroy.notice)
    else
      redirect_to products_path, notice: t(controller.products.destroy.notice_products_path)
    end
  end

  def import
    if params[:xml_file]
      file = params[:xml_file]
      doc = Nokogiri::XML::Document.parse(file)
      total_product = doc.xpath('//offer').take(params[:limit_number].to_i).length
      if params[:russian_sizes].nil?
        params[:russian_sizes] = []
      end
      Product.import(doc, params[:category_id], params[:stranger_category], params[:limit_number], params[:stock], params[:gender], params[:product_type], params[:industry], params[:size], params[:russian_sizes], params[:part_types], params[:skin_types], params[:conditions])
      redirect_to products_path, notice: "#{total_product} Product added."
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
    params.require(:product).permit(:title, :image, :description, :price, :stock, :category_id, :brand_id, :industry, :gender, :product_type, :size, :hypoallergenic, :periodic, :child_sizes, :child_ages, russian_sizes: [], euro_sizes: [], british_sizes: [], american_sizes: [], asian_sizes: [], age_sizes: [], hight_sizes: [], part_types: [], skin_types: [], conditions: [], ages: [], volumes_attributes: [:id, :value, :value_price, :_destroy])
  end
end
