class LessonsMailer < ApplicationMailer
  def notice_user(lesson)
    @lesson = lesson
    mail to: current_user.email, subject: 'レッスンの予約が完了しました'
  end

  def notice_teacher(lesson)
    @lesson = lesson
    mail to: lesson.teacher.email, subject: 'レッスンが予約されました'
  end
end
