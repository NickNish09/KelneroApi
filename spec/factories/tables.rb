FactoryBot.define do
  sequence :number do |n|
    n
  end
end

FactoryBot.define do
  factory :table do
    number { generate :number }
  end
end
