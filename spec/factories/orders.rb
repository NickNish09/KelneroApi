FactoryBot.define do
  factory :order do
    item { create(:item) }
    bill { create(:bill) }
    quantity { 1 }
    details { "Pedido 1" }
  end
end
