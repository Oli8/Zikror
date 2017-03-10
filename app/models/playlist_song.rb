class PlaylistSong < ApplicationRecord
	belongs_to :song
	belongs_to :playlist
	validates :playlist_id, uniqueness: { scope: :song_id, message: 'already contains this song' }
end
