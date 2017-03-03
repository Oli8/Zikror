class RenameIdUserFromSongs < ActiveRecord::Migration[5.0]
  def change
  	rename_column :songs, :id_user, :user_id
  end
end
