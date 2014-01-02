module WriteHelper
	def day_classes(day, selected_day)
		now = Time.zone.now
		classes = ["calendar-day"]
		if day.day == now.day
			classes << "today"
		elsif day.day < now.day
			classes << "past"
		else
			classes << "future"
		end
		classes << "selected" if selected_day && selected_day.is?(day)
		classes.join(" ")
	end
end
