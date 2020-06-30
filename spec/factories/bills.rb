FactoryBot.define do
  factory :bill do
    closed_in { nil }
    table { create(:table) }
  end
end
