FactoryBot.define do
  sequence :name do |n|
    "Categoria #{n}"
  end
end

FactoryBot.define do
  factory :category do
    name { generate :name }
    main { true }

    factory :category_with_items do
      after(:create) do |category, evaluator|
        @item = create(:item)
        ItemCategory.create(item: @item, category: category)
      end
    end
  end
end
