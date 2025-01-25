class Customization < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  belongs_to :category
  has_many :customization_items, dependent: :destroy
end
