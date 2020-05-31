class Teacher::HomeController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_teacher, only: %i[edit update]
  before_action :set_languages, only: %i[edit update]

  def index
  end

  def edit
  end

  def update
    if @teacher.update(teacher_params)
      redirect_to teacher_root_path, notice: 'プロフィールを更新しました'
    else
      render :edit
    end
  end

  private

  def set_teacher
    @teacher = current_teacher
  end

  def set_languages
    @languages = Language.all
  end

  def teacher_params
    params.fetch(:teacher, {}).permit(:name, :profile, :avatar, language_ids: [])
  end
end
