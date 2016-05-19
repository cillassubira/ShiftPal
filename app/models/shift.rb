class Shift < ActiveRecord::Base
	belongs_to :user
	has_many :requests
	enum slot: { Morning: 1, Afternoon: 2, Night: 3, Free: 4, Other: 5}

end
