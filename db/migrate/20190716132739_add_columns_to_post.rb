class AddColumnsToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :area_id, :integer, null: false
  end
end
