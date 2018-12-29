class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :star, default: 5
      t.references :lesson, foreign_key: true
      t.references :booking, foreign_key: true
      t.references :expert, foreign_key: true
      t.references :teacher, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
