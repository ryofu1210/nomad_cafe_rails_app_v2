class CreateItem < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :post, foreign_key: true
      t.integer :sortrank, null: false
      t.references :target, polymorphic: true, index: true
    end
  end
end
