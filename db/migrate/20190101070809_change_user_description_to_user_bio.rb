class ChangeUserDescriptionToUserBio < ActiveRecord::Migration[5.0]
  def change
  	rename_column :users, :description, :biography 
  end
end
