FactoryBot.define do
  factory :product do
    code { Faker::Barcode.unique.ean }
    name { Faker::Name.name }
    price { rand(1000..30_000) }
  end
end
