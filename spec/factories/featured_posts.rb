FactoryBot.define do
  factory :featured_post do
    association :post
    sequence(:sortrank) { |n| n }
  end
end
