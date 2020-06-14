class LessonsController < ApplicationController
  def index
    @q = Lesson.ransack(params[:q])
    @lessons = @q.result.includes(:lesson_reservation, :teacher, :language)
                 .where(lesson_reservations: { id: nil })
  end
end
