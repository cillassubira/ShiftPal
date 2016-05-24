class Shift < ActiveRecord::Base
	belongs_to :user
	has_many :requests
	enum slot: { Morning: 1, Afternoon: 2, Night: 3, Free: 4, Other: 5}

	def self.check_repeated_requests(available_requests, shift_to_be_changed)
		available_requests.map do |available_request|
			if Request.where(shift_requested_id: shift_to_be_changed.id, shift_answering_id: available_request.id, status: 1).empty?
					available_request
			end
		end.compact
	end

	def self.calculate_available_shifts(shift)
		free_shifts = where(day: shift.day, slot: 4)
		free_shifts.map do |free_shift|
			check_incompatibilities(free_shift, shift)
		end.compact
	end

	def self.check_incompatibilities(free_shift, shift)
		case shift.slot
			when "Morning" , "Afternoon"
				possible_shift_before = find_by(day: shift.day - 1 , user: free_shift.user)
				free_shift if possible_shift_before.slot != "Night"
			when "Night"
				possible_shift_after = find_by(day: shift.day + 1 , user: free_shift.user)
				if possible_shift_after.slot != "Morning" && possible_shift_after.slot != "Afternoon"
					free_shift
				end
		end	
	end

	def self.available_shifts_to_return(available_shifts, shift_to_be_changed, initial_date, days_to_check)
		free_shifts_requesting_user = where(day: initial_date..(initial_date + days_to_check), user_id: shift_to_be_changed.user_id, slot: 4)
		returnable_shifts = []
		free_shifts_requesting_user.each do |free_shift|
			available_shifts.each do |user_shift|
				shift_to_be_changed = Shift.find_by(user_id: user_shift.user_id, day: free_shift.day)
				if !check_incompatibilities(free_shift, shift_to_be_changed).nil?
					returnable_shifts << shift_to_be_changed
				end
			end
		end
		returnable_shifts
	end

end
