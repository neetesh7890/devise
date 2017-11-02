class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.references :user, foreign_key: true
      t.string :album_name
      t.integer :comment_count
      t.integer :count

      t.timestamps
    end
  end
end
