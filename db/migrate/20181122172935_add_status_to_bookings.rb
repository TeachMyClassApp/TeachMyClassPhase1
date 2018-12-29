class AddStatusToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :status, :integer, dault: 0
  end
end
