class ReservationRate
  def initialize(lessons)
    @lessons_by_date = lessons
  end

  def hours_range
    7.upto(22)
  end

  def dates
    @lessons_by_date.keys
  end

  def lessons_by_hour(date)
    lessons.group_by { |lesson| lesson.start_at.strftime('%k') }
  end
end
