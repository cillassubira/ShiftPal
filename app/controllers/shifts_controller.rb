class ShiftsController < ApplicationController
	before_action :authenticate_user! 
	before_action :shift_from_user, only: [:show]
  before_action :pending_requests, except: [:shift_info]

	def index
	  @shifts = current_user.shifts
	end

	def show
		@shift_to_be_changed = Shift.find(params[:id])
		available_shifts = Shift.calculate_available_shifts(@shift_to_be_changed)
		available_requests_not_checked = Shift.available_shifts_to_return(available_shifts, @shift_to_be_changed, Date.today + 1, 20)
		@available_requests = Shift.check_repeated_requests(available_requests_not_checked, @shift_to_be_changed)
	end

	def shift_info
		@shift = current_user.shifts.find_by(day: params[:shift_date])
		respond_to do |format|
			format.js{}
		end
	end

	private
	def shift_from_user
      @shift = Shift.find(params[:id])
      unless @shift.user_id == current_user.id
      	flash[:notice] = "Access forbidden."
        redirect_to root_path
      end
    end

  def pending_requests
     @requests_received = Request.where(user_answering_id: params[:user_id], status: 1)
  end
end
