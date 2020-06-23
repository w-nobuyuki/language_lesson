class ChangeColumnToAllowNullFromLessonTicket < ActiveRecord::Migration[6.0]
  def change
    change_column :lesson_tickets, :charge_id, :bigint, null: true
  end
end
