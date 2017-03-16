module UsersHelper

	def gravatar(user, width=50)
		image_tag('https://secure.gravatar.com/avatar/' + Digest::MD5::hexdigest(user.mail.downcase), alt: user.username, class: 'gravatar', width: width)
	end

	def gravatar_src(user)
		'https://secure.gravatar.com/avatar/' + Digest::MD5::hexdigest(user.mail.downcase)
	end

end
