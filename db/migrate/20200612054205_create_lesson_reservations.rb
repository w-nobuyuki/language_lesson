class CreateLessonReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :lesson_reservations do |t|
      t.references :lesson, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
