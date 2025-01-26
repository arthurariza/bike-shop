class V1::ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).order("categories.name ASC", name: :asc)

    render json: @products, each_serializer: V1::ProductsSerializer
  end

  def show
    @product = Product.includes(:category, customizations: :customization_items).find_by!(id: params[:id])

    render json: @product, serializer: V1::ProductSerializer
  end
end
