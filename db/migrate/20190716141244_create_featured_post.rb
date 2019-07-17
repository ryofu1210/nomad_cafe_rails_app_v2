class CreateFeaturedPost < ActiveRecord::Migration[5.2]
  def change
    create_table :featured_posts do |t|
      t.references :post, foreign_key: true
      t.integer :sortrank, null: false
    end
  end
end
