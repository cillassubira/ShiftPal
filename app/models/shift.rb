class Shift < ActiveRecord::Base
	belongs_to :user
	has_many :requests
	has_one :shift_slot
end
