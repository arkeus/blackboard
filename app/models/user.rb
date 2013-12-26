class User < ActiveRecord::Base
	has_secure_password
	
	attr_writer :logged_in
	after_initialize :after_initialize
	
	def after_initialize
		@logged_in = false
	end
	
	# Returns whether this user is authenticated within the current request to be logged in.
  def logged_in?
    @logged_in
  end
end
