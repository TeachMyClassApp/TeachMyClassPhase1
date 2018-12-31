class CalendarsController < ApplicationController
  before_action :authenticate_user!
  include ApplicationHelper

  def index
  end

  def create
    datetime_from = Date.parse(calendar_params[:start_datetime])
    datetime_to = Date.parse(calendar_params[:end_datetime])

    (datetime_from..datetime_to).each do |datetime|
      calendar = Calendar.where(lesson_id: params[:lesson_id], day: datetime)

      if calendar.present?
        calendar.update_all(price: calendar_params[:price], status: calendar_params[:status])
      else
        Calendar.create(
          lesson_id: params[:lesson_id],
          day: datetime,
          price: calendar_params[:price],
          status: calendar_params[:status]
        )
      end
    end

    redirect_to expert_calendar_path
  end

  def expert
    @lessons = current_user.lessons

    params[:start_datetime] ||= Date.current.to_s
    params[:lesson_id] ||= @lessons[0] ? @lessons[0].id : nil

    if params[:q].present?
      params[:start_datetime] = params[:q][:start_datetime]
      params[:lesson_id] = params[:q][:lesson_id]
    end

    @search = Booking.ransack(params[:q])

    if params[:lesson_id]
      @lesson = Lesson.find(params[:lesson_id])
      start_datetime = Date.parse(params[:start_datetime])

      first_of_month = (start_datetime - 1.months).beginning_of_month 
      end_of_month = (start_datetime + 1.months).end_of_month 

      @events = @lesson.bookings.joins(:user)
                      .select('bookings.*, users.username, users.image, users.email, users.uid')
                      .where('(start_datetime BETWEEN ? AND ?) AND status <> ?', first_of_month, end_of_month, 2)
      @events.each{ |e| e.image = avatar_url(e) }
      @days = Calendar.where("lesson_id = ? AND day BETWEEN ? AND ?", params[:lesson_id], first_of_month, end_of_month)
    else
      @lesson = nil
      @events = []
      @days = []
    end
  end

  private
    def calendar_params
      params.require(:calendar).permit([:price, :status, :start_datetime, :end_datetime])
    end
end