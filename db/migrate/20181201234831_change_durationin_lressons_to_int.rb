class ChangeDurationinLressonsToInt < ActiveRecord::Migration[5.0]
  def change
  	change_column :lessons, :duration, :integer
  end
end
