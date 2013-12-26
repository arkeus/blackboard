class Day
	attr_reader :identifier
	
	def initialize(identifier)
		@identifier = identifier
	end
	
	def self.from_time(time = Time.now)
		Day.new(year(time) + month(time) + day(time))
	end
	
	def self.from_string(time_string)
		from_time(Time.zone.parse(time_string))
	end
	
	private
	
	def self.year(time)
		shorten(time.year - 2013)
	end
	
	def self.month(time)
		shorten(time.month - 1)
	end
	
	def self.day(time)
		shorten(time.day - 1)
	end
	
	TRANSLATION_TABLE = (('a'..'z').to_a + ('0'..'9').to_a + ('A'..'Z').to_a).freeze
	def self.shorten(value)
		TRANSLATION_TABLE[value]
	end
end
