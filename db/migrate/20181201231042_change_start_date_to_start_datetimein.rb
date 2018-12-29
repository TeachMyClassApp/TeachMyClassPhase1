class ChangeStartDateToStartDatetimein < ActiveRecord::Migration[5.0]
  def change
  	  	rename_column :bookings, :start_date, :start_datetime
  end
end
