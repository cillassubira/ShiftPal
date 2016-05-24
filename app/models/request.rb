class Request < ActiveRecord::Base
	belongs_to :user_requesting, :class_name => 'User'
	belongs_to :user_answering, :class_name => 'User'
	belongs_to :shift_requesting, :class_name => 'Shift'
	belongs_to :shift_answering, :class_name => 'Shift'
	enum status: { Pending: 1, Accepted: 2, Cancelled: 3, Seen: 4 }

end
