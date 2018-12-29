class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:show]


	def show
		@user  = User.find(params[:id])
		@lessons = @user.lessons

		# Display all teacher reviews to experts, assuming user is expert (has lessons)
		@teacher_reviews = Review.where(type: "TeacherReview", expert_id: @user.id)

		# Display all expert reviews to teachers, assuming user is expert (has lessons)
		@expert_reviews = Review.where(type: "ExpertReview", teacher_id: @user.id)
	end

  def update_phone_number
    current_user.update_attributes(user_params)
    current_user.generate_pin
    current_user.send_pin

    redirect_to edit_user_registration_path, notice: "Saved..."
  rescue Exception => e
    redirect_to edit_user_registration_path, alert: "#{e.message}"
  end

	def verify_phone_number
		current_user.verify_pin(params[:user][:pin])

		if current_user.phone_verified
			flash[:notice] = "Congrats! Your phone number is verified."
		else
			flash[:alert] = "Verification unsuccessful. Try again."
		end

		redirect_to edit_user_registration_path

	rescue Exception => e
		redirect_to edit_user_registration_path, alert: "#{e.message}"
	end

	def payment
	end

	def add_card 
		#stripe
		if current_user.stripe_id.blank?
			customer = Stripe::Customer.create(
				email: current_user.email
			)
			current_user.stripe_id = customer.id
			current_user.save
		else
			customer = Stripe::Customer.retrieve(current_user.stripe_id)
		end 
		
		#card for stripe
		month, year = params[:expiry].split(/ \/ /)
		new_token = Stripe::Token.create(:card => {
			:number =>params[:number],
			:exp_month => 'month',
			:exp_year => 'year',
			:cvc => params[:cvv]
	})
	customer.sources.create(source: new_token.id)

	flash[:notice] = "Thanks for updating your card, it has been saved to Stripe."
	redirect_to payment_method_path
rescue Stripe::CardError => e
	flash[:alert] = "Something went wrong, please check your card details and try again."
	redirect_to payment_method_path
	end
	

	private

	def user_params
		params.require(:user).permit(:phone_number, :pin, :avatar)
	end 
end