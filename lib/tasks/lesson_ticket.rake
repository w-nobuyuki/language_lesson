namespace :lesson_ticket do

  task update_user_id: :environment do
    LessonTicket.where(user_id: nil).each do |lesson_ticket|
      lesson_ticket.update(user_id: lesson_ticket.charge.user.id)
    end
  end
end