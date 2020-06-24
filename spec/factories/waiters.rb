FactoryBot.define do
  factory :waiter do
    name { "John Doe" }
    restaurant { Restaurant.find_by(subdomain: 'app') }
  end
end
