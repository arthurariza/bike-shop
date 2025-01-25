class ProhibitedCombination < ApplicationRecord
  belongs_to :customization_item, class_name: "CustomizationItem"
  belongs_to :prohibited_item, class_name: "CustomizationItem"

  validates :customization_item_id, presence: true
  validates :prohibited_item_id, presence: true
  validate :items_must_be_different
  validates :customization_item_id, uniqueness: { scope: :prohibited_item_id }

  private

  def items_must_be_different
    if customization_item_id == prohibited_item_id
      errors.add(:base, "Cannot prohibit combination of the same item")
    end
  end
end
