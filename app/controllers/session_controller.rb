class SessionController < ApplicationController
  
  def new
  end

  def create
  	user = User.find_by(username: params[:session][:username])
  	if user && user.authenticate(params[:session][:password])
  		puts 'ok'
  		log_in user
  		redirect_to user
  		# format.html { redirect_to @user, notice: "Welcome Back!" }
  	else
  		puts 'nop'
  		flash.now[:notice] = 'Invalid parameters'
  		render 'new'
  	end
  end

  def destroy
  end

end
