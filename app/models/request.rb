class Request < ActiveRecord::Base
	belongs_to :user_requesting, :class_name => 'User'
	belongs_to :user_answering, :class_name => 'User'
	belongs_to :shift_requesting, :class_name => 'Shift'
	belongs_to :shift_answering, :class_name => 'Shift'
	enum status: { Pending: 1, Accepted: 2, Cancelled: 3}


		# def self.check_shift_incompatibilites(shift_to_be_changed, shift_gap)
		# 	case shift_to_be_changed.shift_slot_id
		# 			when 1 , 2
		# 				shift_before = Shift.find_by(day: shift_gap.day - 1 , user_id: shift_to_be_changed.user_id)
		# 					if shift_before.shift_slot_id != 3
		# 						shift_gap
		# 					end
		# 			when 3
		# 				shift_after = Shift.find_by(day: shift_gap.day + 1 , user_id: shift_to_be_changed.user_id)
		# 				if possible_shift_after.shift_slot_id != 1 || possible_shift_after.shift_slot_id !=2
		# 					  shift_gap
		# 				end
		# 		end	
		# end

end
