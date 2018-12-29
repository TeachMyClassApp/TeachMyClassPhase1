class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.string :learning_area
      t.string :achievement_objective
      t.integer :curriculum_level
      t.integer :class_size
      t.string :duration
      t.boolean :registered_teacher_required
      t.boolean :inquiry_learning
      t.boolean :project_learning
      t.string :technology_available
      t.string :description
      t.boolean :kc_thinking
      t.boolean :kc_relating_to_others
      t.boolean :kc_using_language_symbols_and_texts
      t.boolean :kc_participating_and_contributing
      t.string :lesson_name
      t.string :address

      t.timestamps
    end
  end
end
