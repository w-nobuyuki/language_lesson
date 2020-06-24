module LessonHelper
  def h_lesson_datetime(lesson)
    # 好み
    # "#{lesson.start_at.strftime("%Y/%m/%d %H:%M")}～#{lesson.end_at.strftime("%H:%M")}"
    lesson.start_at.strftime("%Y/%m/%d %H:%M") + "～" + lesson.end_at.strftime("%H:%M")
  end
end
