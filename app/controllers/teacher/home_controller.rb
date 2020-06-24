class Teacher::HomeController < Teacher::ApplicationController
  before_action :set_teacher, only: %i[edit update]

  def index; end

  def edit; end

  def update
    if @teacher.update(teacher_params)
      bypass_sign_in(@teacher) # コメントが欲しい
      redirect_to teacher_root_path, notice: 'プロフィールを更新しました'
    else
      render :edit
    end
  end

  private

  def set_teacher
    @teacher = current_teacher
  end

  def teacher_params
    params.require(:teacher).permit(:name, :profile, :avatar, :password, :password_confirmation, language_ids: [])
  end
end
