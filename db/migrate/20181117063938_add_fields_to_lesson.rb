class AddFieldsToLesson < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :latitude, :float
    add_column :lessons, :longitude, :float
  end
end
