class V1::CartItemsController < ApplicationController
  def create
    cart = Cart.includes(cart_items: :purchasable).current_cart

    updated_cart = Cart::AddPurchasableService.call(cart, purchasable)

    if updated_cart.errors.empty?
      render json: updated_cart, serializer: V1::CartSerializer
    else
      render json: { errors: updated_cart.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  private

  def cart_items_params
    params.expect(cart_item: [ :purchasable_id, :purchasable_type ])
  end

  def purchasable
    purchasable_type = cart_items_params[:purchasable_type]
    purchasable_id = cart_items_params[:purchasable_id]

    @purchasable ||= case purchasable_type
    when "Product"
      Product.find(purchasable_id)
    when "CustomizationItem"
      CustomizationItem.find(purchasable_id)
    else
      raise ArgumentError, "Invalid purchasable_type: #{purchasable_type}"
    end
  end
end
