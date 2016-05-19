class RequestsController < ApplicationController
	def index
		#Enviados que no han sido respondindos
		@requests = Request.where(user_requesting_id: params[:user_id])
		@pending_requests = @requests.where(request_status_id: 1)
		#Faltan recibidos que no han sido contestados

	end

	def show
		@shift_to_be_changed = Shift.find(params[:id])
		@available_shifts = Request.calculate_free_shifts(@shift_to_be_changed)
		@available_requests = Request.available_shifts_to_return(@available_shifts, @shift_to_be_changed)
	end

	private


end
