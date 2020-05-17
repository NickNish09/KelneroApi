FactoryBot.define do
  factory :bill do
    final_bill { 19.80 }
    table { create(:table) }
    user { create(:user) }
  end
end
