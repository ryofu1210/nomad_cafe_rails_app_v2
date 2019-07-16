class AddColumnsToPost < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :area, foreign_key: true

  end
end
