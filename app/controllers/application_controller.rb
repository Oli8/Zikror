class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionHelper
  ITEMS_PER_PAGE = 10
end
