class PagesController < ApplicationController
  def home
  	@lessons = Lesson.where(active: true).limit(3)
  end

	def search
	  	if params[:search].present? && params[:search].strip != ""
	  		session[:loc_search] = params[:search]
	  	end 

		if session[:loc_search] && session[:loc_search] != ""
		      @lessons_address = Lesson.where(active: true).near(session[:loc_search], 5, order: 'distance')
		else
		      @lessons_address = Lesson.where(active: true).all
		end

	  	@search = @lessons_address.ransack(params[:q])
	  	@lessons = @search.result

	  	@arrLessons = @lessons.to_a

	  	if (params[:start_date]) && (params[:end_date]) && !params[:start_date].empty? && !params[:end_date].empty?

			start_date = Date.parse(params[:start_date])
			end_date = Date.parse(params[:end_date])

			@lessons.each do |lesson|

				not_available = lesson.bookings.where(
					"((? <= start_date AND start_date <= ?)
					OR (? <= end_date AND end_date <= ?)
					OR (start_date < ? AND ? < end_date)) AND status = ?",
					start_date, end_date,
					start_date, end_date,
					start_date, end_date,
					1
				).limit(1)

				not_available_in_calendar = lesson.calendars.where(
					"status = ? AND ? <= day AND day <= ?",
					1, start_date, end_date
					).limit(1)

				if not_available.length || not_available_in_calendar.length > 0
					@arrLessons.delete(lesson)
				end 
			end 
		end
	end 

def home_search
	
end

def about 
end

def contact 
end

def for_teachers 
end

def for_experts
end

def privacy
end

def terms_of_use
end

def faqs
end
end 
