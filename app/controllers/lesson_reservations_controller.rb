class LessonReservationsController < ApplicationController
  before_action :set_lesson_reservation, only: [:show, :edit, :update, :destroy]

  # GET /lesson_reservations
  # GET /lesson_reservations.json
  def index
    @lesson_reservations = LessonReservation.all
  end

  # GET /lesson_reservations/1
  # GET /lesson_reservations/1.json
  def show
  end

  # GET /lesson_reservations/new
  def new
    @lesson_reservation = LessonReservation.new
  end

  # GET /lesson_reservations/1/edit
  def edit
  end

  # POST /lesson_reservations
  # POST /lesson_reservations.json
  def create
    @lesson_reservation = LessonReservation.new(lesson_reservation_params)

    respond_to do |format|
      if @lesson_reservation.save
        format.html { redirect_to @lesson_reservation, notice: 'Lesson reservation was successfully created.' }
        format.json { render :show, status: :created, location: @lesson_reservation }
      else
        format.html { render :new }
        format.json { render json: @lesson_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lesson_reservations/1
  # PATCH/PUT /lesson_reservations/1.json
  def update
    respond_to do |format|
      if @lesson_reservation.update(lesson_reservation_params)
        format.html { redirect_to @lesson_reservation, notice: 'Lesson reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson_reservation }
      else
        format.html { render :edit }
        format.json { render json: @lesson_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lesson_reservations/1
  # DELETE /lesson_reservations/1.json
  def destroy
    @lesson_reservation.destroy
    respond_to do |format|
      format.html { redirect_to lesson_reservations_url, notice: 'Lesson reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson_reservation
      @lesson_reservation = LessonReservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_reservation_params
      params.require(:lesson_reservation).permit(:lesson_id, :user_id)
    end
end
