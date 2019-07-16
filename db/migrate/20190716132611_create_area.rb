class CreateArea < ActiveRecord::Migration[5.2]
  def change
    create_table :areas do |t|
      t.string :title
    end
  end
end
