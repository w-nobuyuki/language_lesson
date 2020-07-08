class Teacher::LessonReservationsController < Teacher::ApplicationController
  def index
    @lesson_reservations = current_teacher.lesson_reservations
                                          .includes(lesson: [:user, :language])
                                          .order(start_at: 'ASC')
  end
end
