class Teacher::HomeController < ApplicationController
  before_action :authenticate_teacher!

  def index
  end
end
