class ChangePriceToDecimalInLessons < ActiveRecord::Migration[5.0]
  def change
  	change_column :lessons, :price, :decimal
  end
end
