class AddExtraFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :string, :string
    add_column :users, :description, :string
    add_column :users, :text, :string
  end
end
