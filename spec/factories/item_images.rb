FactoryBot.define do
  factory :item_image do
    image {File.open("#{Rails.root}/spec/fixtures/images/store_image.jpg")}
    # source_url 'http://google.com'
    # image { fixture_file_upload("#{Rails.root}/spec/fixtures/images/store_image.jpg", 'image/jpg')}
  end
end
