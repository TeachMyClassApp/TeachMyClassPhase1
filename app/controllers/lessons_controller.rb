class LessonsController < ApplicationController
  before_action :set_lesson, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:show]
  before_action :is_authorised, only: [:listing, :pricing, :description, :photo_upload, :features, :location, :update]
  def index
    @lessons = current_user.lessons
  end

  def new
    @lesson = current_user.lessons.build
  end

  def show
    @photos = @lesson.photos
    @teacher_reviews = @lesson.teacher_reviews
  end

  def create
    @lesson = current_user.lessons.build(lesson_params)
    if @lesson.save
      redirect_to listing_lesson_path(@lesson), notice:"Lesson successfully created!"
    else
       flash[:alert] = "Something when wrong, please check your lesson."
       render :new
    end
  end

  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
    @photos = @lesson.photos
  end

  def features
  end

  def location
  end

  def update
    new_params = lesson_params
    new_params = lesson_params.merge(active: true) if is_ready_lesson()
    if @lesson.update(new_params)
      flash[:notice] = "Updates saved."
    else
      flash[:alert] = "Something when wrong, please check your lesson."
    end 
    redirect_back(fallback_location: request_format)
  end
#Bookings
  def preload
    now = DateTime.now
    bookings = @lesson.bookings.where("(start_datetime >= ? OR end_datetime >= ?) AND status = ?", now, now, status)
    #unavailable_dates = @lesson.calendars.where("status = ? AND session > ?", 1, now)
    #special_dates = @lesson.calendars.where("status = ? AND session > ? AND price <> ?", 0, now, @lesson.price)

    render json: bookings
    #{
      #bookings: bookings,
      #unavailable_dates: unavailable_dates
      #special_dates: special_dates
    #}
  end

  def preview
    start_datetime = Date.parse(params[:start_datetime])
    end_datetime = Date.parse(params[:end_datetime])

    output = {
      conflict: is_conflict(start_datetime, end_datetime, @lesson)
    }
    render json: output
  end

  private
  def is_conflict(start_datetime, end_datetime, lesson)
    check = lesson.bookings.where("(? <start_datetime AND end_datetime < ?) AND status = ?", start_datetime, end_datetime, 1)
    check_2 = lesson.calendars.where("session BETWEEN ? AND ? AND status = ?", start_datetime, end_datetime, 1).limit(1)
    
    check.size >0 || check_2.size >0 ? true : false
  end



  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def is_authorised
    redirect_to root_path, alert: 'You don\'t have permission to go there!' unless current_user.id == @lesson.user_id
  end 

  def is_ready_lesson
    !@lesson.active && !@lesson.price.blank? && !@lesson.photos.blank? && !@lesson.address.blank? && !@lesson.lesson_name.blank?
  end

  def lesson_params
    params.required(:lesson).permit(:learning_area, :achievement_objective, :curriculum_level, :class_size, 
                                      :duration, :registered_teacher_required, :inquiry_learning, :project_learning, 
                                      :technology_available, :description, :kc_thinking, :kc_relating_to_others,
                                      :kc_using_language_symbols_and_texts, :kc_participating_and_contributing, 
                                      :lesson_name, :address, :price, :active, :instant, :pricing_type, :keywords)
  end 
end 

