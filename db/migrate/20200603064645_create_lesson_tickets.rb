class CreateLessonTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :lesson_tickets do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
