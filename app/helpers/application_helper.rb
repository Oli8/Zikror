module ApplicationHelper

	def has_favorite(song)
		FavoriteSong.exists?(user_id: current_user, song_id: song.id)
	end

end
