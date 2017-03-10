class Playlist < ApplicationRecord
	belongs_to :user
	has_many :playlist_songs
	has_many :songs, through: :playlist_songs
	has_attached_file :image
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"],
	message: 'File must an image'

	validates :name,
				presence: true,
				uniqueness: true,
				length: {maximum: 20}

	validates :description,
				length: {maximum: 256}

end
