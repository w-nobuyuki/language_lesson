class FeedbacksController < ApplicationController
  before_action :set_lesson_reservation, only: :index
  def index
    @feedbacks = @lesson_reservation.feedbacks
  end

  private

  def set_lesson_reservation
    @lesson_reservation = current_user.lesson_reservations.find(params[:lesson_reservation_id])
  end
end
