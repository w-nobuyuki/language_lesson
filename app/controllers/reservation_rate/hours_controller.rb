class ReservationRate::HoursController < ApplicationController
  def index
    @q = Lesson.ransack(params[:q])
    @lessons = @q.result
                 .select(:id, :start_at)
                 .includes(:lesson_reservation)
                 .order(start_at: 'ASC')
                 .group_by { |l| l.start_at.to_date }
  end
end