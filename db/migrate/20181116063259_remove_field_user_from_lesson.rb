class RemoveFieldUserFromLesson < ActiveRecord::Migration[5.0]
  def change
    remove_reference :lessons, :User, foreign_key: true
  end
end
