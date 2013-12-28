class IndexController < ApplicationController
	# Home Page
	def index
		
	end
	
	# Action to register a new user
	def register
		raise "Username '#{post_params[:username]}' is taken" if User.exists?(username: post_params[:username])
		user = User.new(post_params)
		user.save!
		session[:user_id] = user.id
		redirect_to write_path
	rescue => e
		flash[:error] = e.message
		redirect_to root_path
	end
	
	# Action to login and forward to expected page
	def login
		user = User.find_by_username(post_params[:username]).try(:authenticate, post_params[:password])
		raise "Invalid username or password" unless user
		session[:user_id] = user.id
		redirect_to write_path
	rescue => e
		flash[:error] = e.message
		redirect_to root_path
	end
	
	# Action to logout and forward to home page
	def logout
		reset_session
		redirect_to root_path
	end
	
	private
	
	def post_params
		@post_params ||= params.permit(:username, :password, :password_confirmation, :email)
	end
end
