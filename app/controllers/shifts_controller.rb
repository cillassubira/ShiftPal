class ShiftsController < ApplicationController
	before_action :authenticate_user! 
	def index
	  @requests_received = Request.where(user_answering_id: params[:user_id], status: 1)
	  @shifts = User.find(current_user.id).shifts
	end

	def show
		@shift_to_be_changed = Shift.find(params[:id])
		@available_shifts = Shift.calculate_available_shifts(@shift_to_be_changed)
		@available_requests = Shift.available_shifts_to_return(
			@available_shifts,
			@shift_to_be_changed, 
			Date.today + 1,
			20)
	end

	def shift_info
		@shift = Shift.find_by(day: params[:shift_date], user_id: current_user.id)
		render json: @shift
		# respond_to do |format|
		# 	format.js
		# end
	end

end
