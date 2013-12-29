class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :set_user
  after_action :save_user
  
  def set_user
  	if session[:user_id]
  		@user = User.find(session[:user_id])
  		@user.logged_in = true
  	else
  		raise "Not logged in"
  	end
  rescue => e
  	@user = User.new
  end
  
  def save_user
  	@user.save! if @user.changed?
  end
  
  def require_login
  	redirect_to root_path unless @user.logged_in?
  end
  
  def redirect_errors
  	begin
  		yield
  	rescue => e
  		flash[:error] = e.message
  		redirect_to root_path
  	end
  end
  
  def render_errors
  	begin
  		yield
  	rescue => e
  		puts Rails.logger.error "#{e.message} #{e.backtrace.reject { |line| line =~ /RailsInstaller/ }.join("\n")}"
  		render json: { error: e.message }, status: 422
  	end
  end
end
