class Document < ActiveRecord::Base
	def self.for_user(user_id, year, month, day = nil)
		where(build_find_params(user_id, year, month, day))
	end
	
	def self.for_user_shared(user_id, year, month, day)
		where(build_find_params(user_id, year, month, day, true))
	end
	
	private
	
	def self.build_find_params(user_id, year, month, day = nil, shared = nil)
		params = {
			user_id: user_id,
			year: year,
			month: month
		}
		params[:day] = day if day
		params[:shared] = true if shared
		params
	end
end
