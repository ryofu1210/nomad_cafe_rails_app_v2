FactoryBot.define do
  factory :area do
    sequence(:name) { |n| "AREA NAME#{n}" }
  end
end
