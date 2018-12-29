class AddBookedStatusToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :booked_status, :integer, default: 0
  end
end
