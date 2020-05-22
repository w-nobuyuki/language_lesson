class Teacher::HomeController < ApplicationController
  before_action :authenticate_teacher!

  def index
  end

  def edit
    @teacher = current_teacher
  end

  def update
    @teacher = current_teacher
  end

  private

  def teacher_params
    
  end
end
