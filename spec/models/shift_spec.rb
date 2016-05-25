#Rspec para app.rb
require 'rails_helper'

RSpec.describe "Shift" do

	before(:each) do
		@user1 = User.create(name: 'Example1', alias: 'EE1', email: 'ee1@example.com', password: '12345678', password_confirmation: '12345678')
		@user2 = User.create(name: 'Example2', alias: 'EE2', email: 'ee2@example.com', password: '12345678', password_confirmation: '12345678')
		
		Shift.create(day: "2016-06-01", user: @user1, slot: 1) 
		Shift.create(day: "2016-06-02", user: @user1, slot: 2)
		Shift.create(day: "2016-06-03", user: @user1, slot: 2)
		Shift.create(day: "2016-06-04", user: @user1, slot: 4)
		Shift.create(day: "2016-06-05", user: @user1, slot: 3)

		Shift.create(day: "2016-06-01", user: @user2, slot: 1)
		Shift.create(day: "2016-06-02", user: @user2, slot: 4)
		Shift.create(day: "2016-06-03", user: @user2, slot: 2)
		Shift.create(day: "2016-06-04", user: @user2, slot: 2)
		Shift.create(day: "2016-06-05", user: @user2, slot: 3)

		@shift_to_be_changed = @user1.shifts.find_by(day: "2016-06-02")
  end

  let(:available_shifts) { Shift.calculate_available_shifts(@shift_to_be_changed) }

  	describe "calculate_available_shifts" do
		it "returns a collection of Shifts that are free and compatible to a Shift User requested to change" do
			expect(Shift.calculate_available_shifts(@shift_to_be_changed).length).to eq(1)
		end
	end

	describe "check_incompatibilites" do
		it "given a shift to change checks imcompatibilities and returns shift if available" do
			free_shift = Shift.where(day: @shift_to_be_changed.day, slot: 4 )[0]
			expect(Shift.check_incompatibilities(free_shift, @shift_to_be_changed)).to eq(free_shift)
		end
	end

	describe "available_shifts_to_return" do
		it "given a collection of available shifts from all users to the shift to change 
			returns a collection of shifts that the user requesting will be able to return in exchange" do
			expect(Shift.available_shifts_to_return(available_shifts, @shift_to_be_changed, Date.new(2016, 06, 01), 4).length).to eq(1)
		end

		it "verifies that user asking for a change will return the shift in exchange in a free day" do
			shifts_to_return = Shift.available_shifts_to_return(available_shifts, @shift_to_be_changed, Date.new(2016, 06, 01), 4)
			expect(@user1.shifts.find_by(day: shifts_to_return[0].day).slot).to eq("Free")
		end
	end


end