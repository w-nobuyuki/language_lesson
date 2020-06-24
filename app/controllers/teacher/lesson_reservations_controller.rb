class Teacher::LessonReservationsController < Teacher::ApplicationController
  def index
    # current_teacher 経由でたどるとより安心
    # :user は直接 includes したほうがよさそう
    # order
    @lesson_reservations = LessonReservation.includes(:user, lesson: [:language])
                                            .where(lessons: { teacher: current_teacher })
  end
end
