class CreatePlaylists < ActiveRecord::Migration[5.0]
  def change
    create_table :playlists do |t|
      t.integer :user_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
