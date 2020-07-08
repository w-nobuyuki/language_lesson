module ReservationRateHelper
  def h_reserved_lessons_count(lessons_array)
    lessons_array.select { |lesson| lesson.lesson_reservation.present? }.count
  end

  def h_reservation_rate_color(reserved_lessons_count, all_lessons_count)
    reservation_rate = reserved_lessons_count / all_lessons_count
    return 'table-danger' if reservation_rate >= 0.86
    return 'table-warning' if reservation_rate >= 51

    'table-primary'
  end
end
