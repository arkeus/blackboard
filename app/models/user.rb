class User < ActiveRecord::Base
	has_secure_password
	
	attr_writer :logged_in
	after_initialize :after_initialize
	
	validates :username, format: { with: /\A[a-zA-Z0-9_-]+\z/, message: "- Only letters, numbers, underscores, and dashes allowed in a username" }
	validates :username, length: { in: 2..30 }
	validates :password, presence: true
	validates :email, presence: true
	
	def after_initialize
		@logged_in = false
	end
	
	# Returns whether this user is authenticated within the current request to be logged in.
  def logged_in?
    @logged_in
  end
end
