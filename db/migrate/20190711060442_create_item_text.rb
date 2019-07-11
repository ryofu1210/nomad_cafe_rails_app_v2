class CreateItemText < ActiveRecord::Migration[5.2]
  def change
    create_table :item_texts do |t|
      t.text :body
    end
  end
end
