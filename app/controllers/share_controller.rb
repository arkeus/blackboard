class ShareController < ApplicationController
	def share
		begin
			@day = Day.from_identifier(safe_params[:day])
			@share_user = User.find(safe_params[:user_id])
			@document = Document.for_user_shared(@share_user.id, @day.year, @day.month, @day.day).first
			raise "Invalid document" unless @document
		rescue => e
			redirect_to write_path and return unless @document
		end
	end
	
	private
	
	def safe_params
		@safe_params ||= params.permit(:day, :user_id)
	end
end
