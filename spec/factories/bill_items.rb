FactoryBot.define do
  factory :bill_item do
    item { create(:item) }
    bill { create(:bill) }
    quantity { 1 }
    details { "Sem feijão" }
  end
end
