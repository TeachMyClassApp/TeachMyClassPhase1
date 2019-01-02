class Booking < ApplicationRecord
	enum status: {Waiting: 0, Approved: 1, Declined: 2}
  enum booked_status: {Upcoming: 0, Confirmed: 1, In_Progress: 2, Completed: 3, Cancelled: 4}

	after_create_commit :create_notification 

  belongs_to :user
  belongs_to :lesson

  private

  def create_notification
  	type = self.lesson.Instant? ? "New Booking" : "New Request"
    teacher = User.find(self.user_id)
    #Notifications.create(content: "#{booking.lesson_name} from #{teacher.username}", user_id: self.lesson.user_id)
  end 
end
