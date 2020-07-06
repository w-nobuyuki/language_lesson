class RemoveUserIdFromLessonReservation < ActiveRecord::Migration[6.0]
  def change
    remove_reference :lesson_reservations, :user, null: false, foreign_key: true
  end
end
