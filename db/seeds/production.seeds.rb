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
	3.times do |i|
    user = FactoryBot.create(:user)
  end
end