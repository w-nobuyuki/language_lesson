class AddUserIdToLessonTicket < ActiveRecord::Migration[6.0]
  def change
    add_column :lesson_tickets, :user_id, :bigint, after: :charge_id
    add_index :lesson_tickets, :user_id
    add_foreign_key :lesson_tickets, :users
  end
end
