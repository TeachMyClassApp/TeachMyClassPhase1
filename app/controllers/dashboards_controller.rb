class DashboardsController < ApplicationController 
	before_action :authenticate_user!

	def index
		@lessons = current_user.lessons
	end 

end
