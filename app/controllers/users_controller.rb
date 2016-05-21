class UsersController < ApplicationController
	def index
		@users = User.all
		respond_to do |format|
			format.js
			format.html
		end
	
	end

	def show
		
	end

end
