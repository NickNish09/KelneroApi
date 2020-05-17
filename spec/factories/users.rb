FactoryBot.define do
  sequence :email do |n|
    "nnmarques#{n}@gmail.com"
  end
end

FactoryBot.define do
  factory :user do
    email { generate :email }
    password { '123456' }
    name { 'Nicholas Marques' }
  end
end
