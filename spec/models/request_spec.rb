require 'rails_helper'

RSpec.describe "Request" do
  before(:each) do
    @request1 = Request.create(user_requesting_id: 1 , user_answering_id: 2 , shift_requested_id: 1 , shift_answering_id: 2 , status: 1 )
    @request2 = Request.create(user_requesting_id: 1 ,user_answering_id: 2 , shift_requested_id: 1 , shift_answering_id: 4 , status: 1 )
    #Request.create(user_requesting_id: ,user_answering_id: , shift_requested_id: , shift_answering_id: , status: )
    #Request.create(user_requesting_id: ,user_answering_id: , shift_requested_id: , shift_answering_id: , status: )

  end

  describe "cancel_other_requests" do
    it "cancels all other requests for the same shift when a user accepts a request" do
    	@request1.update(status: 2)
    	Request.cancel_other_requests(@request1.shift_requested_id, @request1.user_requesting_id)
      #expect(@request2.status).to eq("Cancelled")
      #expect(@request2.status).to eq("Cancelled")
    end
  end
end