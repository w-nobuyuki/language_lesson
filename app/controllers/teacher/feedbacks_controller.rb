class Teacher::FeedbacksController < Teacher::ApplicationController
  before_action :set_lesson_reservation
  before_action :set_feedback, only: %i[edit update destroy]

  def index
    @feedbacks = @lesson_reservation.feedbacks
  end

  def new
    @feedback = @lesson_reservation.feedbacks.build
  end

  def create
    @feedback = @lesson_reservation.feedbacks.build(feedback_params)
    if @feedback.save
      FeedbackMailer.new_feedback(@feedback).deliver_now
      redirect_to teacher_lesson_reservation_feedbacks_url, notice: 'フィードバックを登録しました。'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @feedback.update(feedback_params)
      redirect_to teacher_lesson_reservation_feedbacks_url, notice: 'フィードバックを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @feedback.destroy!
    redirect_to teacher_lesson_reservation_feedbacks_url, notice: 'フィードバックを削除しました。'
  end

  private

  def set_lesson_reservation
    @lesson_reservation = current_teacher.lesson_reservations.only_completed.find(params[:lesson_reservation_id])
  end

  def set_feedback
    @feedback = @lesson_reservation.feedbacks.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit(:body)
  end
end
