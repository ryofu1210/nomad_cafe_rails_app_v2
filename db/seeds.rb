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
	3.times do |i|
	  Post.create(
        title: "post name #{i}",
        description: "post description"
	  )
	end
end