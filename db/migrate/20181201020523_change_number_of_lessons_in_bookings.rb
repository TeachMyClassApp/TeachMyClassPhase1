class ChangeNumberOfLessonsInBookings < ActiveRecord::Migration[5.0]
  def change
  	rename_column :bookings, :number_of_lessons, :number_of_learners

  end
end
