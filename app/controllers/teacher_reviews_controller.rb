class TeacherReviewsController < ApplicationController

	def create
		# 1. Check if booking for lesson between expert and teacher exists,and is in past

		# 2. Check if review has already occured.
		@booking = Booking.where(
					id: teacher_review_params[:booking_id],
					lesson_id: teacher_review_params[:lesson_id],
					).first

		if !@booking.nil? && @booking.lesson.user.id == teacher_review_params[:expert_id].to_i


			has_reviewed = TeacherReview.where(
							booking_id: @booking.id,
							teacher_id: teacher_review_params[:teacher_id]
							).first

				if @has_reviewed.nil?
					@teacher_review = current_user.teacher_reviews.create(teacher_review_params)
				else
					flash[:alert] = "You've already reviewed this lesson, please edit your existing review."
				end


		else
			flash[:alert] = "You can only review lessons which have been completed."

		end


		@teacher_review = current_user.teacher_reviews.create(teacher_review_params)
		flash[:success] = "Review posted!"
		redirect_back(fallback_location: request.referer)
	end

	def destroy
		@teacher_review = Review.find(params[:id])
		@teacher_review.destroy
		redirect_back(fallback_location: request.referer, notice: "Review deleted")
	end



	private
		def teacher_review_params
			params.require(:teacher_review).permit(:comment, :star, :lesson_id, :booking_id, :teacher_id)
		end
end