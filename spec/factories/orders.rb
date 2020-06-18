FactoryBot.define do
  factory :order do
    item { create(:item) }
    command { create(:command) }
    quantity { 1 }
    details { "Pedido 1" }
  end
end
