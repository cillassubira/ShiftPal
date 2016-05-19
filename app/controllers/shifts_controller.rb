class ShiftsController < ApplicationController
	before_action :authenticate_user! 
	def index
	  @user = User.find(current_user.id)
	  @shifts = @user.shifts
	end

	def show
		@user = User.find(params[:user_id])
		@shift = Shift.find(params[:id])
	end

	def people
		@date = params[:date]
		@shifts = Shift.where(day: @date)
		@shifts.where(slot: "Morning")
		render json: @shifts
	end

end
