FactoryBot.define do
  factory :bill_item do
    item { nil }
    bill { nil }
    quantity { 1 }
    details { "MyText" }
  end
end
