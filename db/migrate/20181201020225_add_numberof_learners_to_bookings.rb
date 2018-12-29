class AddNumberofLearnersToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :number_of_lessons, :integer
  end
end
