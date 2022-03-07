FactoryBot.define do
  factory :review do
    association :reviewable, factory: :book
    reviewable_type { 'Book' }
    user
    rating { Faker::Number.between(from: 1, to: 5) }
    description { Faker::Lorem.sentence }
  end

  #TODO: Can add separate trait for author reviews
end
