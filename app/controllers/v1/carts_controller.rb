class V1::CartsController < ApplicationController
  def show
    render json: Cart.includes(cart_items: :purchasable).current_cart, serializer: V1::CartSerializer
  end
end
