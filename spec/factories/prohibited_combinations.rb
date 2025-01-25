FactoryBot.define do
  factory :prohibited_combination do
    association :customization_item, factory: :customization_item
    association :prohibited_item, factory: :customization_item
  end
end
