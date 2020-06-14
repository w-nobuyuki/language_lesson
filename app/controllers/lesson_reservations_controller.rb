class LessonReservationsController < ApplicationController
  before_action :set_lesson_reservation, only: [:show, :edit, :update, :destroy]

  def index
    @lesson_reservations = current_user.lesson_reservations.includes(:lesson)
  end

  def show
  end

  def new
    @lesson_reservation = LessonReservation.new
  end

  def edit
  end

  def create
    @lesson_reservation = current_user.lesson_reservations.build(lesson_reservation_params)

    respond_to do |format|
      if @lesson_reservation.save && current_user.lesson_tickets.first.destroy
        format.html { redirect_to lessons_path, notice: 'Lesson reservation was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @lesson_reservation.update(lesson_reservation_params)
        format.html { redirect_to @lesson_reservation, notice: 'Lesson reservation was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @lesson_reservation.destroy
    respond_to do |format|
      format.html { redirect_to lesson_reservations_url, notice: 'Lesson reservation was successfully destroyed.' }
    end
  end

  private

  def set_lesson_reservation
    @lesson_reservation = LessonReservation.find(params[:id])
  end

  def lesson_reservation_params
    params.require(:lesson_reservation).permit(:lesson_id)
  end
end
