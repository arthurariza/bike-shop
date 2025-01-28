class Cart::RemovePurchasableService < ApplicationService
  def initialize(cart, cart_item)
    @cart = cart
    @cart_item = cart_item
  end

  def call
    return @cart unless cart_item_belongs_to_cart?

    remove_cart_item

    update_cart_total_price

    @cart
  end

  private

  def cart_item_belongs_to_cart?
    @cart_item.cart_id == @cart.id
  end

  def remove_cart_item
    @cart_item.destroy
  end

  def update_cart_total_price
    @cart.update_total_price
  end
end
