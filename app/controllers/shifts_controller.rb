class ShiftsController < ApplicationController
	before_action :authenticate_user! 
	def index
	  @shifts = User.find(current_user.id).shifts
	end

	def show
		@shift_to_be_changed = Shift.find(params[:id])
		@available_shifts = Shift.calculate_free_shifts(@shift_to_be_changed)
		@available_requests = Shift.available_shifts_to_return(@available_shifts, @shift_to_be_changed)
	end

	def shift_info
		shift = Shift.find(params[:id])
		render json: shift
		# respond_to do |format|
		# 	format.js
		# 	format.html
		# end
	end

end
