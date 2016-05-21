class RequestsController < ApplicationController
	def inbox
		@requests_sent = Request.where(user_requesting_id: params[:user_id], status: 1)
		@requests_accepted_by_others = Request.where(user_requesting_id: params[:user_id], status: 2)
		@requests_received = Request.where(user_answering_id: params[:user_id], status: 1)

	end

	def create
		request = Request.new(
			user_requesting_id: params[:user_id], 
			user_answering_id: Shift.find(params[:shift_answering_id]).user_id,
			shift_requested_id: params[:shift_id],
			shift_answering_id: params[:shift_answering_id],
			status: 1
		)
		if request.save
      flash[:success] = "Your request has been sent!"
      #redirect_to @user
    else
      #render 'new'
    end
		# respond_to do |format|
		# 	format.js{}
		# end
	end

	def accept
		request = Request.find(params[:id])

		current_user_shift = Shift.find(request.shift_answering_id)
		collegue_shift = Shift.find(request.shift_requested_id)
		collegue_id = collegue_shift.user_id
		#free corresponding shifts(gaps)
		current_user_gap = Shift.find_by(user_id: current_user.id, day: collegue_shift.day)
		collegue_gap = Shift.find_by(user_id: collegue_id, day: current_user_shift.day)
		#interchanging free shifts(gaps)
		current_user_gap.update(user_id: collegue_id)
		collegue_gap.update(user_id: current_user.id)
		#interchanging Shifts (according to request)
		current_user_shift.update(user_id: collegue_id)
		collegue_shift.update(user_id: current_user.id)
		#updating request to accepted status
		request.update(status: 2)
		#cancelling other requests of same worker for the same shift
		other_requests = Request.where(shift_requested_id: request.shift_requested_id, user_requesting_id: collegue_id, status: 1)
		if !other_requests.empty?
			other_requests.update_all(status: 3)
		end
		redirect_to requests_inbox_path
	end

	def reject
		request = Request.find(params[:id])
		request.update(status: 3)
		redirect_to requests_inbox_path
	end

	def mark_as_seen
		request = Request.find(params[:id])
		request.update(status: 4)
		redirect_to requests_inbox_path

	end


end
