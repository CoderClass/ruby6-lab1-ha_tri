class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :username
      t.text :caption
      t.integer :likes_count
      t.string :url

      t.timestamps
    end
  end
end
