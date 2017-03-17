class User < ApplicationRecord
	has_many :songs, dependent: :destroy
	has_many :playlists, dependent: :destroy
	has_many :favorite_songs, dependent: :destroy

	validates :username,
				presence: {message: 'Veuillez saisir un nom d\'utilisateur'},
				uniqueness: {message: 'Ce nom d\'utilisateur existe déjà'},
				format: {with: /\A[A-Za-z][A-Za-z\d_]*\z/, message: 'Votre nom doit commencer par une lettre et peut contenir les caractère suivant (chiffres, underscore)'}
	validates_length_of :username, within: 3..20, too_long: 'Veuillez saisir un nom entre 3 et 20 caractère', too_short: 'Veuillez saisir un nom entre 3 et 20 caractère'

	validates :mail,
				presence: {message: 'Veuillez saisir une adresse email'},
				uniqueness: {message: 'Cet adresse email existe déjà'},
				format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: 'Veuillez saisir une adresse mail valide'}

	has_secure_password
	validates :password,
				presence: {message: 'Veuillez saisir un mot de passe'},
				format: {with: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\A/, message: 'Votre mot de passe doit comprendre au moins une lettre minuscule, une lettre majuscule et un chiffre numérique'}
				validates_length_of :password, within: 3..20, too_long: 'Veuillez saisir un nom entre 6 et 50 caractère', too_short: 'Veuillez saisir un mot de passe entre 6 et 50 caractère'

end
	