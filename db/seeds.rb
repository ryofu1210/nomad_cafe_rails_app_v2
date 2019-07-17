require 'factory_bot'

TABLES = %w(
  users posts items item_headings item_texts item_images
)

ActiveRecord::Base.connection.execute("SET FOREIGN_KEY_CHECKS=0;");
TABLES.each do |table_name|
  ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table_name};")
end
ActiveRecord::Base.connection.execute("SET FOREIGN_KEY_CHECKS=1;");

ActiveRecord::Base.transaction do
  posts = []
	3.times do |i|
    user = FactoryBot.create(:user)
    2.times do |j|
      post = FactoryBot.create(:post, user: user)
      FactoryBot.create(:item, :heading, sortrank: 1, post: post)
      FactoryBot.create(:item, :text, sortrank: 2, post: post)
      FactoryBot.create(:item, :image, sortrank: 3, post: post)
      posts << post
    end
  end
  FactoryBot.create(:featured_post, post: posts[0])
  FactoryBot.create(:featured_post, post: posts[3])
  FactoryBot.create(:featured_post, post: posts[5])

end