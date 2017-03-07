class Playlist < ApplicationRecord
	belongs_to :user

	validates :name,
				presence: true,
				uniqueness: true,
				length: {maximum: 20}

	validates :description,
				length: {maximum: 256}
				
end
