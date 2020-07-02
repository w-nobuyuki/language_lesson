module LessonHelpers
  def lesson_datetime(lesson)
    "#{lesson.start_at.strftime('%Y/%m/%d %H:%M')}～#{lesson.end_at.strftime('%H:%M')}"
  end
end