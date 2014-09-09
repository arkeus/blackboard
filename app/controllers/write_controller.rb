class WriteController < ApplicationController
	before_action :require_login
	around_action :render_errors, only: [:update_title, :update_content]
	around_action :with_user_time_zone
	
	# Write for a given day, defaulting to the current day
	def write
		@day = post_params[:day] ? Day.from_identifier(post_params[:day]) : Day.from_time(Time.zone.now)
		@docs = Document.for_user(@user.id, @day.year, @day.month)
		@progress = Hash[*@docs.map { |doc| [Day.calculate_identifier(doc.year, doc.month, doc.day), (doc.words.to_f / doc.goal)] }.flatten]
		@document = get_or_create_document(@user, @day)
	end
	
	# Update the title for a single document
	def update_title
		day = Day.from_identifier(post_params[:day])
		document = Document.for_user(@user.id, day.year, day.month, day.day).first
		raise "Unknown document" unless document
		document.title = post_params[:title]
		document.save!
		render_ok
	end
	
	# Update the content for a single document
	def update_content
		day = Day.from_identifier(post_params[:day])
		document = Document.for_user(@user.id, day.year, day.month, day.day).first
		raise "Unknown document" unless document
		document.content = post_params[:content]
		document.words = count_words(post_params[:content])
		document.save!
		render_ok
	end
	
	# Toggles shareability for a single document
	def share
		day = Day.from_identifier(post_params[:day])
		document = Document.for_user(@user.id, day.year, day.month, day.day).first
		raise "Unknown document" unless document
		document.shared = !document.shared
		document.save!
		if document.shared
			redirect_to shared_path(@user.id, post_params[:day])
		else
			redirect_to write_path(post_params[:day])
		end
	end
	
	private
	
	def get_or_create_document(user, day)
		document = Document.for_user(user.id, day.year, day.month, day.day).first
		return document if document
		
		now = day.time.strftime("%A %B #{day.day.ordinalize}")
		Document.create(goal: user.goal, user_id: user.id, year: day.year, month: day.month, day: day.day, title: "Untitled Document (#{now})")
	end
	
	def count_words(content)
		content.split(/\s+/).count
	end
	
	def render_ok
		render nothing: true, status: 200
	end
	
	def post_params
		@post_params ||= params.permit(:title, :day, :content)
	end
end
