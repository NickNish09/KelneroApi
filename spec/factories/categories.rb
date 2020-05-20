FactoryBot.define do
  sequence :name do |n|
    "Categoria #{n}"
  end
end

FactoryBot.define do
  factory :category do
    name { generate :name }
    main { true }
  end
end
