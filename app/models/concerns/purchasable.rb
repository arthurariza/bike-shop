module Purchasable
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true
    validates :name, uniqueness: true

    validates :price, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0 }

    has_many :cart_items, as: :purchasable, dependent: :destroy
  end

  def price=(value)
    super(BigDecimal(value))
  rescue ArgumentError, TypeError
    super(nil)
  end
end
