module RequestsHelper
	def display_shift(id)
		Shift.find(id)
	end
	def display_user(id)
		User.find(id)
	end
end
