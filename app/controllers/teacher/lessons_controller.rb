class Teacher::LessonsController < Teacher::ApplicationController
  before_action :set_lesson, only: %i[show edit update destroy]

  def index
    @lessons = current_teacher.lessons
  end

  def show
  end

  def new
    @lesson = current_teacher.lessons.build
  end

  def edit
  end

  def create
    @lesson = current_teacher.lessons.build(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to teacher_lessons_url, notice: 'Lesson was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to teacher_lessons_url, notice: 'Lesson was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to teacher_lessons_url, notice: 'Lesson was successfully destroyed.' }
    end
  end

  private
    def set_lesson
      @lesson = current_teacher.lessons.find(params[:id])
    end

    def lesson_params
      params.require(:lesson).permit(:language_id, :start_at)
    end
end
