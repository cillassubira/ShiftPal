class ShiftsController < ApplicationController
	before_action :authenticate_user! 
	def index
	  @user = User.find(current_user.id)
	  @shifts = @user.shifts
	end

	def show
		@user_id = current_user.id
		@shift_to_be_changed = Shift.find(params[:id])
		@available_shifts = Shift.calculate_free_shifts(@shift_to_be_changed)
		@available_requests = Shift.available_shifts_to_return(@available_shifts, @shift_to_be_changed)

	end


	def other
		@user = User.find(params[:user_id])
		@shift = Shift.find(params[:id])
		render json: @shift
	end


	private

end
