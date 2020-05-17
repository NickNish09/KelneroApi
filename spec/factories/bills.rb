FactoryBot.define do
  factory :bill do
    final_bill { 1.5 }
    table { nil }
    user { nil }
  end
end
