class V1::Admin::CustomizationItemStocksController < ApplicationController
  def update
    customization_item = CustomizationItem.find_by!(id: params[:id])

    if customization_item.update(in_stock: in_stock_param)
      render json: customization_item, serializer: V1::Admin::CustomizationItemSerializer
    else
      render json: customization_item.errors, status: :unprocessable_entity
    end
  end

  private

  def in_stock_param
    params.expect(:in_stock)
  end
end
