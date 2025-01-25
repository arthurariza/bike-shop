class V1::Admin::CustomizationItemsController < ApplicationController
  before_action :set_customization
  before_action :set_customization_item, only: %i[ show update destroy ]

  def index
    @customization_items = @customization.customization_items.order(:name)

    render json: @customization_items, each_serializer: V1::Admin::CustomizationItemSerializer
  end

  def show
    render json: @customization_item, serializer: V1::Admin::CustomizationItemSerializer
  end

  def create
    @customization_item = @customization.customization_items.new(customization_item_params)

    if @customization_item.save
      render json: @customization_item, status: :created, serializer: V1::Admin::CustomizationItemSerializer
    else
      render json: @customization_item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @customization_item.update(customization_item_params)
      render json: @customization_item, serializer: V1::Admin::CustomizationItemSerializer
    else
      render json: @customization_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @customization_item.destroy!
  end

  private
    def set_customization
      @customization = Customization.find(params[:customization_id])
    end

    def set_customization_item
      @customization_item = @customization.customization_items.find(params[:id])
    end

    def customization_item_params
      params.require(:customization_item).permit(:name, :price, :in_stock)
    end
end
