FactoryBot.define do
  factory :shortened_url do
    destination_url   { Faker::Internet.url }
    access_count      { Faker::Number.between(from: 0, to: 200) }
  end
end
