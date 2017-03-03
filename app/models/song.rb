class Song < ApplicationRecord
	has_attached_file :file
	validates_attachment_content_type :file, :content_type => ['audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio'],
	message: 'File must be mp3'

	validates :title,
				presence: true,
				length: {maximum: 50}

	validates :artist,
				presence: true,	
				length: {maximum: 50}

	validates :file,
				presence: true

end
