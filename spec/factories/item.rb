FactoryBot.define do
  factory :item do
    association :post
    sequence(:sortrank) {|n| n}

    trait :heading do
      association :target, factory: :item_heading
      # target_type 'ItemHeading'
    end

    trait :image do
      association :target, factory: :item_image
      # target_type 'ItemImage'
    end

    trait :text do
      association :target, factory: :item_text
      # target_type 'ItemText'
    end
  end
end
