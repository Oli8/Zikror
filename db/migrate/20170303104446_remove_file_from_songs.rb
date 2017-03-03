class RemoveFileFromSongs < ActiveRecord::Migration[5.0]
  def change
  	remove_column :songs, :file
  end
end
