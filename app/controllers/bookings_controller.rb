class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:approve, :decline]

  def create
    lesson = Lesson.find(params[:lesson_id])

    if current_user == lesson.user
      flash[:alert] = "You cannot book your own lesson!"
      #elsif current_user.stripe_id.blank?
      #flash[:alert] = "First, please update your payment method."
      #return redirect_to payment_method_path
    else
      start_datetime = Date.parse(booking_params[:start_datetime])
      end_datetime = Date.parse(booking_params[:end_datetime])
      length = start_datetime + (lesson.duration / 60).to_i 
      number_of_learners = number_of_learners

      @booking = current_user.bookings.build(booking_params)
      @booking.lesson = lesson
      @booking.price = lesson.price
      @booking.number_of_learners = number_of_learners

      
      @booking.save
      flash[:notice] = "That booking request has been sent to the owner!"  
      redirect_to lesson
    end

  end

  def your_plans
    @plans = current_user.bookings.order(start_datetime: :asc)
  end

  def your_bookings
    @lessons = current_user.lessons
  end

  #def approve
  #  charge(@booking.lesson, @booking)
   # redirect_to your_bookings_path
 # end

  #def decline
       # @booking.Declined!
    #redirect_to your_bookings_path
  #end 

private

#notify lesson expert of new booking
     def send_booking_sms(lesson, booking)
      @client = Twilio::REST::Client.new
      @client.messages.create(
        from: ENV["TWILIO_PHONE_NUMBER"],
       to: lesson.user.phone_number,
       body: "#{booking.user.username} has booked your '#{lesson.listing_name}. Log into teachmyclass.me for more details."
        )
   end

    def set_booking
      @booking = Booking.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(:start_datetime, :end_datetime, :number_of_learners)
    end
end