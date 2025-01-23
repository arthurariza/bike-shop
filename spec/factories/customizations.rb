FactoryBot.define do
  factory :customization do
    sequence(:name) { |n| "Customization #{n}" }
    category
  end
end
