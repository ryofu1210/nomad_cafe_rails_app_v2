class CreatePost < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.string :image
      t.integer :status, default: 0, null: false

      t.integer :recommend_degree, null: false, default: 0
      t.integer :wifi, null: false, default: 0
      t.text :wifi_detail
      t.integer :outret, null: false, default: 0
      t.integer :longstay_degree, null: false, default: 0

      t.timestamps
    end
  end
end
