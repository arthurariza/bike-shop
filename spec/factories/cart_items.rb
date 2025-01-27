FactoryBot.define do
  factory :cart_item do
    cart
    purchasable { create(:product) }
  end
end
