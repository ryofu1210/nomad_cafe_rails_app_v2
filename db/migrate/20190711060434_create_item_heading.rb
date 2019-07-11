class CreateItemHeading < ActiveRecord::Migration[5.2]
  def change
    create_table :item_headings do |t|
      t.string :title
    end
  end
end
