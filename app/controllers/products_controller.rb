class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :products_urls]
  before_action :admin_permission, except: [:show, :products_urls]

  def index
    @products = Product.all
    @category = Category.all
  end

  def new
    @product = Product.new
    @product.volumes.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: 'Products was saved successfully'
    else
      render :new, notice: 'Product was not saved successfully'
    end
  end

  def show
    @line_item = LineItem.new
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to @product, notice: 'Product was update successfully'
    else
      render :edit, notice: 'Product was not update successfully'
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path, notice: 'Product was delete successfully'
    else
      redirect_to products_path, notice: 'Ordered Product cant be delete'
    end
  end

  def products_urls
    @products = []
    if !params[:ids].nil?
      params[:ids].each do |id|
        @products << Product.find(id) if Product.where(id: id).any?
      end
    else
      false
    end

    @recommender = params[:recommender]
    respond_to do |format|
      format.js
    end
  end

  # require 'xml'
  #
  # def import
  #   if params[:xml_file]
  #     file = params[:xml_file]
  #     raw_xml = open(file).read
  #     source = XML::Parser.string(raw_xml)
  #     content = source.parse
  #
  #     total_product = content.root.find('//offer').take(params[:limit_number].to_i).length
  #
  #     if Product.import(content, params[:category_id], params[:stranger_category], params[:limit_number]) == false
  #       redirect_to products_path, notice: "Cant find stranger category id."
  #     else
  #       redirect_to products_path, notice: "#{total_product} Product added."
  #     end
  #   else
  #     redirect_to products_path, notice: "Upload file and fill up form please"
  #   end
  # end

  def import
    if params[:xml_file]
      file = params[:xml_file]
      doc = Nokogiri::XML::Document.parse(file)
      total_product = doc.xpath('//offer').take(params[:limit_number].to_i).length

      Product.import(doc, params[:category_id], params[:stranger_category], params[:limit_number], params[:stock], params[:gender], params[:product_type], params[:industry], params[:size], params[:russian_sizes])
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
