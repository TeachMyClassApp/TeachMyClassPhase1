class ExpertReviewsController < ApplicationController

	def create
		# 1. Check if booking for lesson between expert and teacher exists,and is in past

		# 2. Check if review has already occured.
		@booking = Booking.where(
					id: expert_review_params[:booking_id],
					lesson_id: expert_review_params[:lesson_id],
					user_id: expert_review_params[:teacher_id]
					).first

		if !@booking.nil?


			has_reviewed = ExpertReview.where(
							booking_id: @booking.id,
							teacher_id: expert_review_params[:teacher_id]
							).first

				if @has_reviewed.nil?
					@expert_review = current_user.expert_reviews.create(expert_review_params)
				else
					flash[:alert] = "You've already reviewed this lesson, please edit your existing review."
				end


		else
			flash[:alert] = "You can only review lessons which have been completed."

		end


		@expert_review = current_user.expert_reviews.create(expert_review_params)
		flash[:success] = "Review posted!"
		redirect_back(fallback_location: request.referer)
	end

	def destroy
		@expert_review = Review.find(params[:id])
		@expert_review.destroy
		redirect_back(fallback_location: request.referer, notice: "Review deleted")
	end



	private
		def expert_review_params
			params.require(:expert_review).permit(:comment, :star, :lesson_id, :booking_id, :teacher_id)
		end
end