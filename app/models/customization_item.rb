class CustomizationItem < ApplicationRecord
  include Purchasable

  belongs_to :customization
  has_many :prohibited_combinations, dependent: :destroy
end
