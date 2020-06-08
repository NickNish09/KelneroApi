FactoryBot.define do
  factory :bill do
    final_bill { 19.80 }
    table { create(:table) }
    user { create(:user) }

    factory :bill_with_orders do
      transient do
        items_count { 10 }
      end

      after(:create) do |bill, evaluator|
        create_list(:order, evaluator.items_count, bill: bill)
      end
    end
  end
end
