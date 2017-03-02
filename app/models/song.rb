class Song < ApplicationRecord

	validates :title,
				presence: true,
				length: {maximum: 50}

	validates :artist,
				presence: true,	
				length: {maximum: 50}

	validates :file,
				presence: true

end
