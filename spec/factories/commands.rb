FactoryBot.define do
  factory :command do
    final_bill { 19.80 }
    table { create(:table) }
    user { create(:user) }

    factory :command_with_orders do
      transient do
        items_count { 10 }
      end

      after(:create) do |command, evaluator|
        create_list(:order, evaluator.items_count, command: command)
      end
    end
  end
end
