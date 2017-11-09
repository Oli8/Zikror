class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionHelper
  before_filter :set_constants

	def set_constants
		@slogan = 'Let the Music Flow'
		@description = 'Écoutez de la musique simplement, créez vos playlist et plus encore sur Zikror !'
	end

  def render404
    render file: 'public/404', status: 404
  end
end
