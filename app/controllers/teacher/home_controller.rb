class Teacher::HomeController < Teacher::ApplicationController
  before_action :set_teacher, only: %i[edit update]

  def index; end

  def edit; end

  def update
    if @teacher.update_with_password(teacher_params)
      # パスワード変更時は再ログインが必要なため
      # https://github.com/heartcombo/devise/blob/master/app/controllers/devise/registrations_controller.rb#L54
      bypass_sign_in(@teacher)
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
    params.require(:teacher).permit(:name, :profile, :avatar, :password, :password_confirmation, :current_password, language_ids: [])
  end
end
