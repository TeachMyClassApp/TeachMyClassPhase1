class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :lesson, foreign_key: true
      t.string :start_date
      t.string :datetime
      t.datetime :end_date
      t.integer :price
      t.string :total
      t.string :integer

      t.timestamps
    end
  end
end
