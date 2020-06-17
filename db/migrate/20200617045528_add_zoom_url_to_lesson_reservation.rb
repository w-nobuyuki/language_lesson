class AddZoomUrlToLessonReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :lesson_reservations, :zoom_url, :string, null: false
  end
end
