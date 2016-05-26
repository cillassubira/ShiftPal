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

  def self.invalid_next_day_requests
    requests = Request.where(status: 1)
    requests.each do |request|
      if Shift.find_by(id: request.shift_requested_id).day == Date.today + 1 ||
        Shift.find_by(id: request.shift_answering_id).day == Date.today + 1
        request.update(status: 4)
      end
    end
  end

end