class Request < ActiveRecord::Base
	belongs_to :user_requesting, :class_name => 'User'
	belongs_to :user_answering, :class_name => 'User'
	belongs_to :shift_requesting, :class_name => 'Shift'
	belongs_to :shift_answering, :class_name => 'Shift'
	has_one :request_status

	def self.calculate_free_shifts(shift)
		free_shifts = Shift.where(day: shift.day, shift_slot_id: 4)
		available_requests = [ ]
		free_shifts.each do |possible_shift|
			asked_user = possible_shift.user_id
			case shift.shift_slot_id
				when 1 , 2
					possible_shift_before = Shift.find_by(day: shift.day - 1 , user_id: asked_user)
						if possible_shift_before != 3
							available_requests.push(possible_shift)
						end
				when 3
					possible_shift_after = Shift.find_by(day: shift.day + 1 , user_id: asked_user)
					if possible_shift_after.shift_slot_id != 1 || possible_shift_after.shift_slot_id !=2
						available_requests.push(possible_shift)
					end
			end	
		end
		available_requests
	end

			def self.available_shifts_to_return(available_shifts, shift_to_be_changed)

			available_requests = []
			date1 = Date.new(2016,06,01)
			date2 = Date.new(2016,06,15)
			free_shifts_requesting_user = Shift.where(day: date1..date2, user_id: shift_to_be_changed.user_id, shift_slot_id: 4)	
		
			available_shifts.each do |shift|
			answering_user = shift.user_id
				free_shifts_requesting_user.each do |possible_shift|
					answering_user_shift =  Shift.find_by(day: possible_shift.day, user_id: shift.user_id)
				
				case answering_user_shift.shift_slot_id
					when 1 , 2
						possible_shift_before = Shift.find_by(day: answering_user_shift.day - 1 , user_id: shift_to_be_changed.user_id)
							if possible_shift_before.shift_slot_id != 3
								available_requests.push(answering_user_shift)
							end
					when 3
						possible_shift_after = Shift.find_by(day: answering_user_shift.day + 1 , user_id: shift_to_be_changed.user_id)
						if possible_shift_after.shift_slot_id != 1 || possible_shift_after.shift_slot_id !=2
							available_requests.push(answering_user_shift)
						end
				end	
				end

			end
			available_requests
		end




		def self.check_shift_incompatibilites(shift_to_be_changed, shift_gap)
			case shift_to_be_changed.shift_slot_id
					when 1 , 2
						shift_before = Shift.find_by(day: shift_gap.day - 1 , user_id: shift_to_be_changed.user_id)
							if shift_before.shift_slot_id != 3
								shift_gap
							end
					when 3
						shift_after = Shift.find_by(day: shift_gap.day + 1 , user_id: shift_to_be_changed.user_id)
						if possible_shift_after.shift_slot_id != 1 || possible_shift_after.shift_slot_id !=2
							  shift_gap
						end
				end	
		end

end
