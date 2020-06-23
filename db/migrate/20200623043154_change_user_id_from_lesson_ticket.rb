class ChangeUserIdFromLessonTicket < ActiveRecord::Migration[6.0]
  def change
    change_column :lesson_tickets, :user_id, :bigint, null: false
  end
end
