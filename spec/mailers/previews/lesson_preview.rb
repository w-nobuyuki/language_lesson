# Preview all emails at http://localhost:3000/rails/mailers/lessons
class LessonsPreview < ActionMailer::Preview
  def notice_user
    lesson = Lesson.joins(:lesson_reservation).first
    LessonMailer.notice_user(lesson)
  end

  def notice_teacher
    lesson = Lesson.joins(:lesson_reservation).first
    LessonMailer.notice_teacher(lesson)
  end
end
