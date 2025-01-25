FactoryBot.define do
  factory :customization_item do
    sequence(:name) { |n| "Customization Item #{n}" }
    price { "9.99" }
    in_stock { true }
    customization
  end
end
