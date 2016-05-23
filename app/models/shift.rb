class Shift < ActiveRecord::Base
	belongs_to :user
	has_many :requests
	enum slot: { Morning: 1, Afternoon: 2, Night: 3, Free: 4, Other: 5}

	def self.calculate_available_shifts(shift)
			free_shifts = Shift.where(day: shift.day, slot: 4)
			Shift.check_incompatibilities(free_shifts, shift)
	end

	def self.check_incompatibilities(free_shifts, shift)
		available_requests = []
		free_shifts.each do |possible_shift|
			case shift.slot
				when "Morning" , "Afternoon"
					possible_shift_before = Shift.find_by(day: shift.day - 1 , user_id: possible_shift.user_id)
					if possible_shift_before.slot != "Night"
						available_requests.push(possible_shift)
					end
				when "Night"
					possible_shift_after = Shift.find_by(day: shift.day + 1 , user_id: possible_shift.user_id)
					if possible_shift_after.slot != "Morning" && possible_shift_after.slot != "Afternoon"
						available_requests.push(possible_shift)
					end
			end	
		end
		available_requests
	end

	def self.available_shifts_to_return(available_shifts, shift_to_be_changed, initial_date, days_to_check)
		available_requests = []
		free_shifts_requesting_user = Shift.where(day: initial_date..(initial_date + days_to_check), user_id: shift_to_be_changed.user_id, slot: 4)	
		available_shifts.each do |shift|
			free_shifts_requesting_user.each do |possible_shift|
				answering_user_shift =  Shift.find_by(day: possible_shift.day, user_id: shift.user_id)
				case answering_user_shift.slot
					when "Morning" , "Afternoon"
						possible_shift_before = Shift.find_by(day: answering_user_shift.day - 1 , user_id: shift_to_be_changed.user_id)
							if possible_shift_before && possible_shift_before.slot != "Night"
								available_requests.push(answering_user_shift)
							end
					when "Night"
						possible_shift_after = Shift.find_by(day: answering_user_shift.day + 1 , user_id: shift_to_be_changed.user_id)
						if possible_shift_after && possible_shift_after.slot != "Morning" && possible_shift_after.slot != "Afternoon"
							available_requests.push(answering_user_shift)
						end
				end	
			end
		end
		available_requests
	end


end
