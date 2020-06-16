# Preview all emails at http://localhost:3000/rails/mailers/lessons
class LessonsPreview < ActionMailer::Preview
  def notice_user
    LessonMailer.notice_user(lesson)
  end

  def notice_teacher
    LessonMailer.notice_teacher(lesson)
    
  end

  private
  def 
    
  end
end
