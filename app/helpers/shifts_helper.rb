module ShiftsHelper

	def add_class_shift(day)
		day_shift = @shifts.find_by(day: day)
		if day_shift.class == Shift
			td_class = []
    	td_class << 'morning-shift'         if day_shift.shift_slot_id == 1
    	td_class << 'afternoon-shift'       if day_shift.shift_slot_id == 2
    	td_class << 'night-shift'           if day_shift.shift_slot_id == 3
    	td_class << 'free-shift'            if day_shift.shift_slot_id == 4
    end
    td_class
  end

end


