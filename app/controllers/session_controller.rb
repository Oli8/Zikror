class SessionController < ApplicationController
  
  def new
	redirect_to user_path(current_user) if logged_in?
	@user = User.new
  end

  def create
  	user = User.find_by(username: params[:session][:username])
  	if user && user.authenticate(params[:session][:password])
  		log_in user
  		redirect_to user
  	else
		@user = User.new
  		flash.now[:notice] = 'Invalid parameters'
  		render 'new'
  	end
  end

  def destroy
	log_out
	redirect_to root_url
  end

end
