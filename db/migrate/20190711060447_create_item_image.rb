class CreateItemImage < ActiveRecord::Migration[5.2]
  def change
    create_table :item_images do |t|
      t.string :image
    end
  end
end
