class Document < ActiveRecord::Base
	def self.for_user(user_id, year, month, day = nil)
		params = {
			user_id: user_id,
			year: year,
			month: month
		}
		params[:day] = day if day
		where(params)
	end
end
