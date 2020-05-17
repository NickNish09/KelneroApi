FactoryBot.define do
  factory :item_category do
    item { create(:item) }
    category { create(:category) }
  end
end
