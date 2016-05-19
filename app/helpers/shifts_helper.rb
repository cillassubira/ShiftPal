module ShiftsHelper

	def add_class_shift(day)
		day_shift = @shifts.find_by(day: day)
		if day_shift.class == Shift
			td_class = []
    	td_class << 'morning-shift'         if day_shift.slot == "Morning"
    	td_class << 'afternoon-shift'       if day_shift.slot == "Afternoon"
    	td_class << 'night-shift'           if day_shift.slot == "Night"
    	td_class << 'free-shift'            if day_shift.slot == "Free"
    end
    td_class
  end

end


