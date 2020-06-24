class Teacher::LessonReservationsController < Teacher::ApplicationController
  def index
    @lesson_reservations = LessonReservation.includes(lesson: [:user, :language])
                                            .where(lessons: { teacher: current_teacher })
  end
end
