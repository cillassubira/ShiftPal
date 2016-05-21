class RequestsController < ApplicationController
	def inbox
		@user_id = params[:user_id]
		@requests_sent = Request.where(user_requesting_id: params[:user_id], status: 1)
		@requests_accepted_by_others = Request.where(user_requesting_id: params[:user_id], status: 2)
		@requests_received = Request.where(user_answering_id: params[:user_id], status: 1)
	end


	def accept
		request = Request.find(params[:id])
		current_shift_user = Shift.find(request.shift_answering_id)
		#current_shift_collegue = Shift.find
		new_shift_user = Shift.find(request.shift_requested_id)
		#new_shift_collegue = 
		collegue_id = new_shift_user.user_id
		current_shift_user.update(user_id: collegue_id)

		new_shift_user.update(user_id: current_user.id)
		#falta cambiar los libress


		request.update(status: 2)
		#otras peticiones mismo turno
		other_requests = Request.where(shift_requested_id: new_shift_user, user_requesting_id: collegue_id)
		if !other_requests.empty?
			other_requests.update(status: 3)
		end



	end

	def create
		# binding.pry
		@user_requesting_id = params[:user_id]
		@user_answering_id = Shift.find(params[:shift_answering_id]).user_id
		@shift_requested_id = params[:shift_id]
		@shift_answering_id = params[:shift_answering_id]
		hello = Request.create(
			user_requesting_id: @user_requesting_id, 
			user_answering_id: @user_answering_id,
			shift_requested_id: @shift_requested_id,
			shift_answering_id: @shift_answering_id,
			status: 1
			)
		respond_to do |format|
			format.js{}
		end
	end



	private



end
