class CalendarsController < ApplicationController
  before_action :authenticate_user!
  include ApplicationHelper

  def index
  end

  def create
    date_from = Date.parse(calendar_params[:start_date])
    date_to = Date.parse(calendar_params[:end_date])

    (date_from..date_to).each do |date|
      calendar = Calendar.where(lesson_id: params[:lesson_id], day: date)

      if calendar.present?
        calendar.update_all(price: calendar_params[:price], status: calendar_params[:status])
      else
        Calendar.create(
          lesson_id: params[:lesson_id],
          day: date,
          price: calendar_params[:price],
          status: calendar_params[:status]
        )
      end
    end

    redirect_to expert_calendar_path
  end

  def expert
    @lessons = current_user.lessons

    params[:start_date] ||= Date.current.to_s
    params[:lesson_id] ||= @lessons[0] ? @lessons[0].id : nil

    if params[:q].present?
      params[:start_date] = params[:q][:start_date]
      params[:lesson_id] = params[:q][:lesson_id]
    end

    @search = Booking.ransack(params[:q])

    if params[:lesson_id]
      @lesson = Lesson.find(params[:lesson_id])
      start_date = Date.parse(params[:start_date])

      first_of_month = (start_date - 1.months).beginning_of_month 
      end_of_month = (start_date + 1.months).end_of_month 

      @events = @lesson.bookings.joins(:user)
                      .select('bookings.*, users.username, users.image, users.email, users.uid')
                      .where('(start_date BETWEEN ? AND ?) AND status <> ?', first_of_month, end_of_month, 2)
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
      params.require(:calendar).permit([:price, :status, :start_date, :end_date])
    end
end