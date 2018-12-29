class AddFieldUserToLesson < ActiveRecord::Migration[5.0]
  def change
    add_reference :lessons, :User, foreign_key: true
  end
end
