FactoryBot.define do
  factory :post do
    association :user
    sequence(:name) {|n| "STORE NAME#{n}"}
    description {"説明説明説明説明説明説明説明説明説明説明説明説明"}
    image {File.open("#{Rails.root}/spec/fixtures/images/store_image.jpg")}
    status {1}
    recommend_degree {1}
    wifi {1}
    wifi_detail {"Wi2/Wi2_club"}
    outret {1}
    longstay_degree {1}
    area_id {1}

    trait :editing do
      status {0}
    end

    trait :accepted do
      status {1}
    end

    trait :deleted do
      status {2}
    end

  end
end
