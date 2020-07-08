class Teacher::LessonsController < Teacher::ApplicationController
  before_action :set_lesson, only: %i[edit update destroy]

  def index
    @lessons = current_teacher.lessons.order(start_at: 'ASC')
  end

  def new
    @lesson = current_teacher.lessons.build
  end

  def edit; end

  def create
    @lesson = current_teacher.lessons.build(lesson_params)

    if @lesson.save
      redirect_to teacher_lessons_url, notice: 'レッスン枠を登録しました。'
    else
      render :new
    end
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to teacher_lessons_url, notice: 'レッスン枠を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @lesson.destroy!
    redirect_to teacher_lessons_url, notice: 'レッスン枠を削除しました。'
  end

  private

  def set_lesson
    @lesson = current_teacher.lessons.includes(:lesson_reservation)
                             .where(lesson_reservations: { id: nil })
                             .find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:language_id, :start_at)
  end
end
