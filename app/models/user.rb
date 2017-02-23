class User < ApplicationRecord

	validates :username,
				presence: true,
				uniqueness: true,
				length: {minimum: 3, maximum: 20},
				format: {with: /\A[A-Za-z][A-Za-z\d_]*\z/, message: 'must starts with a letter and includes only letters and digits or underscore'}

	validates :mail,
				presence: true,
				uniqueness: true,
				format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: 'must be valid'}

	has_secure_password
	validates :password,
				presence: true,
				length: {minimum: 6, maximum: 50},
				format: {with: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\A/, message: 'must includes at least one lower case letter, one upper case letter and one numeric digit.'}

end
