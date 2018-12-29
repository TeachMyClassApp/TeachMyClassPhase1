class PhotosController < ApplicationController

	def create
		@lesson = Lesson.find(params[:lesson_id])

		if params[:images]
			params[:images].each do |img|
				@lesson.photos.create(image: img)
				end 

		@photos = @lesson.photos
		redirect_back(fallback_location: request.referer, notice: "Photo saved.")
		end
	end 
	def destroy
		@photo = Photo.find(params[:id])
		@lesson = @photo.lesson

		@photo.destroy
		@photos = Photo.where(lesson_id: @lesson.id)

		respond_to :js
	end 
end
