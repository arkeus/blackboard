class Month < ActiveRecord::Base
	def initialize(time = Time.zone.now)
		@range = time.all_month
	end
	
	def num_days
		@range.last.day
	end
	
	def each_day
		day = @range.first
		while @range.cover?(day)
			yield(Day.from_time(day))
			day += 1.day
		end
	end
end
