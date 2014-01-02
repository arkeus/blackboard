class Day
	attr_reader :identifier, :year, :month, :day
	
	def initialize(year, month, day)
		@identifier = self.class.calculate_identifier(year, month, day)
		@year = year
		@month = month
		@day = day
	end
	
	def time
		@time ||= Time.new(@year, @month, @day)
	end
	
	def is?(time)
		year == time.year && month == time.month && day == time.day
	end
	
	# Whether we can go further into the past from this day. True if >= feb 2013
	def pastable
		time >= Time.new(2013, 2, 1)
	end
	
	# Whether we can go further into the future from this day. True if <= current month
	def futureable
		now = Time.zone.now
		@year < now.year || (@year == now.year && @month < now.month)
	end
	
	# Static
	
	def self.from_time(time = Time.zone.now)
		Day.new(time.year, time.month, time.day)
	end
	
	def self.from_string(time_string)
		from_time(Time.zone.parse(time_string))
	end
	
	def self.from_identifier(identifier)
		Day.new(decode_year(identifier[0]), decode_month(identifier[1]), decode_day(identifier[2]))
	end
	
	def self.calculate_identifier(year, month, day)
		encode_year(year) + encode_month(month) + encode_day(day)
	end
	
	private
	
	TRANSLATION_TABLE = (('a'..'z').to_a + ('0'..'9').to_a + ('A'..'Z').to_a).freeze
	
	def self.encode_year(year)
		encode(year - 2013)
	end
	
	def self.encode_month(month)
		encode(month - 1)
	end
	
	def self.encode_day(day)
		encode(day - 1)
	end
	
	def self.decode_year(year)
		decode(year) + 2013
	end
	
	def self.decode_month(month)
		decode(month) + 1
	end
	
	def self.decode_day(day)
		decode(day) + 1
	end
	
	def self.encode(value)
		TRANSLATION_TABLE[value]
	end
	
	def self.decode(value)
		TRANSLATION_TABLE.index(value)
	end
end
