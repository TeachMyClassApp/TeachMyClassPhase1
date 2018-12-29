class AddPricingTypeToLessons < ActiveRecord::Migration[5.0]
  def change
  	add_column :lessons, :pricing_type, :integer, default: 0
  end
end
