FactoryBot.define do
  factory :tag do
    sequence(:name) {|n| "TAG NAME#{n}"}
  end
end