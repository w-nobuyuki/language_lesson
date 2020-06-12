class Teacher::ApplicationController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_teacher!
end