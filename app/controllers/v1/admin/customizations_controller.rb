class V1::Admin::CustomizationsController < ApplicationController
  before_action :set_category
  before_action :set_customization, only: %i[ show update destroy ]

  def index
    @customizations = @category.customizations.order(:name)

    render json: @customizations, each_serializer: V1::Admin::CustomizationSerializer
  end

  def show
    render json: @customization, serializer: V1::Admin::CustomizationSerializer
  end

  def create
    @customization = @category.customizations.new(customization_params)

    if @customization.save
      render json: @customization, status: :created, serializer: V1::Admin::CustomizationSerializer
    else
      render json: @customization.errors, status: :unprocessable_entity
    end
  end

  def update
    if @customization.update(customization_params)
      render json: @customization, serializer: V1::Admin::CustomizationSerializer
    else
      render json: @customization.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @customization.destroy!
  end

  private
    def set_category
      @category = Category.find(params[:category_id])
    end

    def set_customization
      @customization = @category.customizations.find(params[:id])
    end

    def customization_params
      params.require(:customization).permit(:name)
    end
end
