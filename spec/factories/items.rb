FactoryBot.define do
  factory :item do
    name { "Litrão Skol" }
    price { 9.9 }
    available { true }
    quantity { 10 }

    factory :item_with_category do
      after(:create) do |item, evaluator|
        ItemCategory.create(item: item, category: create(:category))
      end
    end
  end
end
