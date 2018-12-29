class AddColumnKeywordsToLessons < ActiveRecord::Migration[5.0]
  def change
  	    add_column :lessons, :keywords, :string
  end
end
