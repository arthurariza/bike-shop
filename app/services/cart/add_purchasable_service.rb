class Cart::AddPurchasableService < ApplicationService
  def initialize(cart, purchasable)
    @cart = cart
    @purchasable = purchasable
  end

  def call
    purchasable_must_be_in_stock
    return @cart if cart_has_errors?

    check_for_prohibited_combinations if customization_item?
    return @cart if @cart.errors.any?

    add_purchasable_to_cart

    @cart.update_total_price

    @cart
  end

  private

  def cart_has_errors?
    @cart.errors.any?
  end

  def customization_item?
    @purchasable.is_a?(CustomizationItem)
  end

  def purchasable_must_be_in_stock
    return if @purchasable.in_stock?

    @cart.errors.add(:base, "#{@purchasable.name} is out of stock")
  end

  def check_for_prohibited_combinations
    existing_items = @cart.cart_items.where(purchasable_type: "CustomizationItem")

    existing_items.each do |cart_item|
      customization_item = cart_item.purchasable

      if ProhibitedCombination.where(
        "(customization_item_id = ? AND prohibited_item_id = ?) OR (customization_item_id = ? AND prohibited_item_id = ?)",
        customization_item.id, @purchasable.id,
        @purchasable.id, customization_item.id
      ).exists?
        @cart.errors.add(
          :base,
          "#{@purchasable.name} cannot be combined with #{customization_item.name}"
        )
        break
      end
    end
  end

  def add_purchasable_to_cart
    @cart.cart_items.create(purchasable: @purchasable)
  end
end
