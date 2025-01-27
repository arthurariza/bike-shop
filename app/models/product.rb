class Product < ApplicationRecord
  include Purchasable

  belongs_to :category
  has_many :customizations, through: :category
  has_many :customization_items, through: :customizations
end
