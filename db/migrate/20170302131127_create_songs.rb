class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.integer :id_user
      t.string :title
      t.string :artist
      t.integer :year
      t.string :genre
      t.boolean :private

      t.timestamps
    end
  end
end
