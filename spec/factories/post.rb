FactoryBot.define do
  factory :post do
    association :user
    name {"store name"}
    description {"説明説明説明説明説明説明説明説明説明説明説明説明"}
    status {0}
    recommend_degree {1}
    wifi {1}
    wifi_detail {"Wi2/Wi2_club"}
    outret {1}
    longstay_degree {1}
  end
end
