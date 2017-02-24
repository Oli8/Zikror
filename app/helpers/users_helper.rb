module UsersHelper

	def gravatar(user)
		image_tag('https://secure.gravatar.com/avatar/' + Digest::MD5::hexdigest(user.mail.downcase), alt: user.username, class: 'gravatar')
	end

end
