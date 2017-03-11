module SessionHelper

	def log_in(user)
		session[:user_id] = user.id
	end

	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	def logged_in?
		!current_user.nil?
	end

	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

	def correct_user?
		params[:id].to_i == current_user.id
	end

	def require_login
		unless logged_in?
			flash[:notice] = 'You are not authorized to access this page, please log in'
			redirect_to root_path
		end
	end

	def is_owner
      if !correct_user?
        flash[:notice] = 'You are not authorized to access this page'
        redirect_to user_path(current_user)
      end
    end

    def owner?(stuff)
		stuff.user == current_user
    end

end
