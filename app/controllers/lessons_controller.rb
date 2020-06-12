class LessonsController < ApplicationController
  def index
    @lessons = Lesson.left_joins(:lesson_reservation).where(lesson_reservation: { id: nil })
  end
end
