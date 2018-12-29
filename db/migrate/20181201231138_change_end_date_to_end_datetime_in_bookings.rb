class ChangeEndDateToEndDatetimeInBookings < ActiveRecord::Migration[5.0]
  def change
  	  	rename_column :bookings, :end_date, :end_datetime
  end
end
