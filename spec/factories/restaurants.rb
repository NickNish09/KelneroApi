FactoryBot.define do
  factory :restaurant do
    name { "Taioba" }
    opening_hour { "12:00" }
    closing_hour { "16:30" }
    is_open { true }
    subdomain { "taioba" }
  end
end
