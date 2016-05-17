# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

shift_slots = ShiftSlot.create([
	{slot: 'M'},
	{slot: 'A'},
	{slot: 'N'},
	{slot: 'F'},
	{slot: 'F'}
	])

request_statuses = RequestStatus.create([
	{status: 'Requested'},
	{status: 'Accepted'},
	{status: 'Cancelled'}
	])


users = User.create([
  {name: 'Elena', alias: 'EOM', email: 'eom@example.com', password: '12345678', password_confirmation: '12345678'},
  {name: 'David', alias: 'DVC', email: 'dvc@example.com', password: '12345678', password_confirmation: '12345678'},
  {name: 'Alberto', alias: 'AGP', email: 'agp@example.com', password: '12345678', password_confirmation: '12345678'},
  {name: 'Sara', alias: 'SMA', email: 'sma@example.com', password: '12345678', password_confirmation: '12345678'},
  {name: 'Luis', alias: 'LMD', email: 'lmd@example.com', password: '12345678', password_confirmation: '12345678'},
  {name: 'Pedro', alias: 'PGM', email: 'pgm@example.com', password: '12345678', password_confirmation: '12345678'},
  {name: 'Maria', alias: 'MES', email: 'mes@example.com', password: '12345678', password_confirmation: '12345678'},
  {name: 'Laura', alias: 'LBB', email: 'lbb@example.com', password: '12345678', password_confirmation: '12345678'},
  {name: 'Ana', alias: 'AFL', email: 'afl@example.com', password: '12345678', password_confirmation: '12345678'},
  {name: 'Pablo', alias: 'PGA', email: 'pga@example.com', password: '12345678', password_confirmation: '12345678'}
])

def rosterpair (user1, user2, first_day, last_day )
	shift_num = 1
	(first_day..last_day).each_with_index do |day, index|
		unless (shift_num>5)
			Shift.create([
				{shift_slot_id: shift_num, day: day, user_id: user1},
				{shift_slot_id: shift_num, day: day, user_id: user2},
				])
			if (index%2!=0)
				shift_num = shift_num +1
			end
		end
		if (shift_num==6)
			shift_num =1
		end
	end
end

rosterpair(1,2, Date.new(2016, 06, 01), Date.new(2016, 06, 30))
rosterpair(3,4, Date.new(2016, 05, 24), Date.new(2016, 06, 30))
rosterpair(5,6, Date.new(2016, 05, 26), Date.new(2016, 06, 30))
rosterpair(7,8, Date.new(2016, 05, 28), Date.new(2016, 06, 30))
rosterpair(9,10, Date.new(2016, 05, 30), Date.new(2016, 06, 30))

# (day1..day30).each_with_index do |day, index|
# 	unless (shift_num>5)
# 		Shift.create([
# 			{shift_slot_id: shift_num, day: day, user_id: 1},
# 			{shift_slot_id: shift_num, day: day, user_id: 2},
# 			{shift_slot_id: shift_num+4, day: day, user_id: 3},
# 			{shift_slot_id: shift_num+4, day: day, user_id: 4},
# 			{shift_slot_id: shift_num+3, day: day, user_id: 5},
# 			{shift_slot_id: shift_num+3, day: day, user_id: 6},
# 			{shift_slot_id: shift_num+2, day: day, user_id: 7},
# 			{shift_slot_id: shift_num+2, day: day, user_id: 8},
# 			{shift_slot_id: shift_num+1, day: day, user_id: 9},
# 			{shift_slot_id: shift_num+1, day: day, user_id: 10}
# 			])
# 		if (index%2!=0)
# 			shift_num = shift_num +1
# 		end
# 	end
# 	if (shift_num==6)
# 		shift_num =1
# 	end
# end

shifts = Shift.where(shift_slot_id: 5).update_all(shift_slot_id:4)

