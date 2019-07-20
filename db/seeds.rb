require 'factory_bot'

TABLES = %w(
  users posts items item_headings item_texts item_images 
  favorites featured_posts impressions tags post_tags
)

ActiveRecord::Base.connection.execute("SET FOREIGN_KEY_CHECKS=0;");
TABLES.each do |table_name|
  ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table_name};")
end
ActiveRecord::Base.connection.execute("SET FOREIGN_KEY_CHECKS=1;");

ActiveRecord::Base.transaction do
  users = []
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
    users << user
  end
  # byebug
  FactoryBot.create(:favorite, user: users[0], post: posts[0]) 
  FactoryBot.create(:favorite, user: users[1], post: posts[0])
  FactoryBot.create(:favorite, user: users[1], post: posts[1])
  FactoryBot.create(:featured_post, post: posts[0])
  FactoryBot.create(:featured_post, post: posts[3])
  FactoryBot.create(:featured_post, post: posts[5])


  tags = []
  5.times do |k|
    tag = FactoryBot.create(:tag)
    tags << tag
  end
  FactoryBot.create(:post_tag, post: posts[0], tag: tags[0])
  FactoryBot.create(:post_tag, post: posts[0], tag: tags[3])
  FactoryBot.create(:post_tag, post: posts[1], tag: tags[2])
  FactoryBot.create(:post_tag, post: posts[1], tag: tags[4])
end