class LessonsMailer < ApplicationMailer
  add_template_helper(LessonHelper)
  def notice_user(lesson)
    @lesson = lesson
    mail to: lesson.user.email, subject: '【tryout】レッスンの予約が完了しました'
  end

  def notice_teacher(lesson)
    @lesson = lesson
    mail to: lesson.teacher.email, subject: '【tryout】レッスンが予約されました'
  end
end
