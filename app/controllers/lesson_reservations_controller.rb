class LessonReservationsController < ApplicationController
  def index
    @lesson_reservations = current_user.lesson_reservations.includes(lesson: %i[teacher language]).order("lessons.start_at asc")
  end

  def create
    if current_user.lesson_tickets.not_used.blank?
      redirect_to items_path, notice: 'レッスンの予約にはチケットの購入が必要です'
      return
    end
    @lesson_reservation = LessonReservation.new(lesson_reservation_params)
    @lesson_reservation.assign_zoom_url
    @lesson_reservation.lesson_ticket = current_user.lesson_tickets.not_used.first

    respond_to do |format|
      if @lesson_reservation.save
        LessonMailer.notice_user(@lesson_reservation.lesson).deliver_now
        LessonMailer.notice_teacher(@lesson_reservation.lesson).deliver_now
        format.html { redirect_to lessons_path, notice: 'レッスンを予約しました。' }
      else
        format.html { redirect_to lessons_path, alert: @lesson_reservation.errors.full_messages.join }
      end
    end
  end

  private

  def lesson_reservation_params
    params.require(:lesson_reservation).permit(:lesson_id)
  end
end
