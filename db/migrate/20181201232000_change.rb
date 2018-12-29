class Change < ActiveRecord::Migration[5.0]
  def change
  	  	change_column :bookings, :start_datetime, :datetime
  end
end
