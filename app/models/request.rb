class Request < ActiveRecord::Base
	belongs_to :user_requesting, :class_name => 'User'
	belongs_to :user_answering, :class_name => 'User'
	belongs_to :shift_requesting, :class_name => 'Shift'
	belongs_to :shift_answering, :class_name => 'Shift'
	enum status: { Pending: 1, Accepted: 2, Cancelled: 3, Seen: 4 }

  def self.cancel_other_requests(shift_requested_id, user_requesting_id)
    other_requests = Request.where(shift_requested_id: shift_requested_id, user_requesting_id: user_requesting_id, status: 1)
    if !other_requests.empty?
      other_requests.update_all(status: 3)
    end
  end

end
