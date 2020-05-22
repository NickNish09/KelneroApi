FactoryBot.define do
  factory :order do
    item { nil }
    bill { nil }
    quantity { 1 }
    details { "MyText" }
  end
end
