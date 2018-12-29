class AddInstantToLessons < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :instant, :integer, default: 1
  end
end
