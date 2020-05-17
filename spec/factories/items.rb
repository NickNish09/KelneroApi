FactoryBot.define do
  factory :item do
    name { "MyString" }
    price { 1.5 }
    available { false }
    quantity { 1 }
  end
end
