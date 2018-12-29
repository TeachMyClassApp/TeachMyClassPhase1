class SettingsController < ApplicationController

	def edit
		@setting = User.find(current_user.id).setting
	end

	def update
		@setting = User.find(current_user.id).setting
		if @setting.update(setting_params)
			flash[:notice] =  "Changes saved."
		else 
			flash[:alert] = "Cannot save changes, please try again."
		end 
		render 'edit'
	end




private

	def setting_params
		params.require(:setting).permit(:enable_sms, :enable_email)
	end 

end