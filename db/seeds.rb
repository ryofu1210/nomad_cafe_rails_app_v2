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
  # byebug
	3.times do |i|
    user = FactoryBot.create(:user)
    3.times do |j|
      post1 = FactoryBot.create(:post, user: user)
      FactoryBot.create(:item, :heading, sortrank: 1, post: post1)
      FactoryBot.create(:item, :text, sortrank: 2, post: post1)
      FactoryBot.create(:item, :image, sortrank: 3, post: post1)
      posts << post1
      post2 = FactoryBot.create(:post, user: user, status: 0)
      FactoryBot.create(:item, :heading, sortrank: 1, post: post2)
      FactoryBot.create(:item, :text, sortrank: 2, post: post2)
      FactoryBot.create(:item, :image, sortrank: 3, post: post2)
      posts << post2
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
  FactoryBot.create(:featured_post, post: posts[2])
  FactoryBot.create(:featured_post, post: posts[8])
  FactoryBot.create(:featured_post, post: posts[11])
  # FactoryBot.create(:featured_post, post: posts[9])
  # FactoryBot.create(:featured_post, post: posts[10])


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