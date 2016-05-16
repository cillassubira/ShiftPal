class Request < ActiveRecord::Base
	belongs_to :user_requesting, :class_name => 'User'
	belongs_to :user_answering, :class_name => 'User'
	belongs_to :shift_requesting, :class_name => 'Shift'
	belongs_to :shift_answering, :class_name => 'Shift'
	has_one :request_status
end
