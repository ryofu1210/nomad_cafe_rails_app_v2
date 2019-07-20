FactoryBot.define do
  factory :post do
    association :user
    sequence(:name) {|n| "STORE NAME#{n}"}
    description {"説明説明説明説明説明説明説明説明説明説明説明説明"}
    image {File.open("#{Rails.root}/spec/fixtures/images/store_image.jpg")}
    status {0}
    recommend_degree {1}
    wifi {1}
    wifi_detail {"Wi2/Wi2_club"}
    outret {1}
    longstay_degree {1}
    area_id {1}
  end
end
