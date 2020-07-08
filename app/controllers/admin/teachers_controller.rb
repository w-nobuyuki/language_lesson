class Admin::TeachersController < Admin::ApplicationController
  before_action :set_teacher, only: %i[show edit update destroy login]

  def index
    # ASC は order(:id) で ok
    @teachers = Teacher.all.order(id: 'ASC')
  end

  def new
    @teacher = Teacher.new
  end

  def edit; end

  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.save
      redirect_to admin_teachers_url, notice: '講師を登録しました。'
    else
      render :new
    end
  end

  def update
    if params[:teacher][:password].blank? && params[:teacher][:password_confirmation].blank?
      params[:teacher].delete(:password)
      params[:teacher].delete(:password_confirmation)
    end
    if @teacher.update(teacher_params)
      redirect_to admin_teachers_url, notice: '講師を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @teacher.destroy!
    redirect_to admin_teachers_url, notice: '講師を削除しました。'
  end

  def login
    sign_in :teacher, @teacher
    redirect_to teacher_root_url
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:email, :password, :password_confirmation, :name)
  end
end
