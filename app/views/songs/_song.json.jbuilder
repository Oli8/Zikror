json.extract! song, :id, :id_user, :title, :artist, :year, :genre, :private, :created_at, :updated_at
json.url song_url(song, format: :json)