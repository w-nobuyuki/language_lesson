class Teacher::ReservedLessonsController < Teacher::ApplicationController
  def index
    @lessons = current_teacher.lessons.joins(:lesson_reservation).includes(:user, :language)
  end
end
