
module ShiftsHelper

  def add_class_shift(day)
		day_shift = @shifts.find_by(day: day)
		if day_shift.class == Shift
			td_class = []
    	td_class << 'morning-shift'         if day_shift.slot == "Morning"
    	td_class << 'afternoon-shift'       if day_shift.slot == "Afternoon"
    	td_class << 'night-shift'           if day_shift.slot == "Night"
    	td_class << 'free-shift'            if day_shift.slot == "Free"
      td_class << 'not-for-change'        if day < Date.today
    end
    td_class
  end

  def display_shift_hours(shift_slot)
    hours = ''
    case shift_slot
      when "Morning"
        hours = "06:45 to 14:00 LT"
      when "Afternoon"
        hours = "13:45 to 21:00 LT"
      when "Night"
        hours = "20:45 to 07:00 LT"
    end
    return "Remember working hours from " + hours
  end

  def display_collegues(day, user)
    Shift.where(day: day, slot: slot)
  end

end


