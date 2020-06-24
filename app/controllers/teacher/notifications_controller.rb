class Teacher::NotificationsController < Teacher::ApplicationController
  before_action :set_lesson_reservation
  before_action :set_notification, only: %i[edit update destroy]

  def index
    @notifications = @lesson_reservation.notifications
  end

  def new
    @notification = @lesson_reservation.notifications.build
  end

  def create
    @notification = @lesson_reservation.notifications.build(notification_params)
    if @notification.save
      redirect_to teacher_lesson_reservation_notifications_url, notice: '申し送り事項を登録しました。'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @notification.update(notification_params)
      redirect_to teacher_lesson_reservation_notifications_url, notice: '申し送り事項を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @notification.destroy
    redirect_to teacher_lesson_reservation_notifications_url, notice: '申し送り事項を削除しました。'
  end

  private

  def set_lesson_reservation
    @lesson_reservation = current_teacher.lesson_reservations.only_completed.find(params[:lesson_reservation_id])
  end

  def set_notification
    @notification = @lesson_reservation.notifications.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(:body)
  end
end
