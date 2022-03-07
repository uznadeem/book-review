FactoryBot.define do
  factory :book do
    author
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph }
  end
end
