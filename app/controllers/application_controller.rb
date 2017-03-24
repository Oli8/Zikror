class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionHelper
  ITEMS_PER_PAGE = 10

  def render404
    render file: 'public/404', status: 404
  end
end
