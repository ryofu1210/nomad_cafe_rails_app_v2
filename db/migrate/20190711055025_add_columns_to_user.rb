class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :string, null: false, default: ""
    add_column :users, :profile, :text
    add_column :users, :avatar, :string
    add_column :users, :role, :integer, null: false, default: 0
  end
end
