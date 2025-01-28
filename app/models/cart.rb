class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def total_price=(value)
    super(BigDecimal(value, Float::DIG))
  rescue ArgumentError, TypeError
    super(nil)
  end

  # This is a workaround to get the current cart
  # In a real application, we would use a session or a cookie to store the cart
  # For now, we will use the first cart in the database
  def self.current_cart
    cart = Cart.first

    cart || Cart.create!(total_price: "0")
  end

  def update_total_price
    total_price = cart_items.joins("LEFT JOIN products ON products.id = cart_items.purchasable_id AND cart_items.purchasable_type = 'Product'")
      .joins("LEFT JOIN customization_items ON customization_items.id = cart_items.purchasable_id AND cart_items.purchasable_type = 'CustomizationItem'")
      .sum("COALESCE(products.price, 0) + COALESCE(customization_items.price, 0)")

    update(total_price:)
  end
end
