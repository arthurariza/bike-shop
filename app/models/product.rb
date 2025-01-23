class Product < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :category

  def price=(value)
    super(BigDecimal(value))
  rescue ArgumentError, TypeError
    super(nil)
  end
end
