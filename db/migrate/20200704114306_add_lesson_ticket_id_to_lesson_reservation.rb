class AddLessonTicketIdToLessonReservation < ActiveRecord::Migration[6.0]
  def change
    add_reference :lesson_reservations, :lesson_ticket, null: false, foreign_key: true
  end
end
