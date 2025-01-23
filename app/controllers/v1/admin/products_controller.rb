class V1::Admin::ProductsController < ApplicationController
  before_action :set_category
  before_action :set_product, only: %i[ show update destroy ]

  def index
    @products = @category.products.order(:name)

    render json: @products, each_serializer: V1::ProductSerializer
  end

  def show
    render json: @product, serializer: V1::ProductSerializer
  end

  def create
    @product = @category.products.new(product_params)

    if @product.save
      render json: @product, status: :created, serializer: V1::ProductSerializer
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, serializer: V1::ProductSerializer
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy!
  end

  private
    def set_category
      @category = Category.find(params.expect(:category_id))
    end

    def set_product
      @product = @category.products.find(params.expect(:id))
    end

    def product_params
      params.expect(product: [ :name, :in_stock, :price ])
    end
end
