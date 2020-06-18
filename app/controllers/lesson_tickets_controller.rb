class LessonTicketsController < ApplicationController
  def index
    @lesson_tickets = current_user.lesson_tickets
  end
end
