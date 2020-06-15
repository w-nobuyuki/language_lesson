class Admin::TeachersController < Admin::ApplicationController
  before_action :set_teacher, only: %i[show edit update destroy]

  def index
    @teachers = Teacher.all
  end

  def show
    sign_in(:teacher, Teacher.find(params[:id]))
    redirect_to teacher_root_url
  end

  def new
    @teacher = Teacher.new
  end

  def edit; end

  def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to admin_teachers_url, notice: 'Teacher was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to [:admin, @teacher], notice: 'Teacher was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @teacher.destroy
    respond_to do |format|
      format.html { redirect_to admin_teachers_url, notice: 'Teacher was successfully destroyed.' }
    end
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def teacher_params
    params.fetch(:teacher, {}).permit(:email, :password, :password_confirmation, :name)
  end
end
