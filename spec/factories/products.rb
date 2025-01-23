FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    in_stock { true }
    price { "9.99" }
    category
  end
end
