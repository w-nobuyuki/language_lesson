class LessonTicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @lesson_tickets = LessonTicket.all
  end

  def show
  end

  def new
    @lesson_ticket = current_user.lesson_tickets.build
  end

  def edit
  end

  def create
    @lesson_ticket = current_user.lesson_tickets.build(lesson_ticket_params)

    respond_to do |format|
      if @lesson_ticket.save
        format.html { redirect_to @lesson_ticket, notice: 'Lesson ticket was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @lesson_ticket.update(lesson_ticket_params)
        format.html { redirect_to @lesson_ticket, notice: 'Lesson ticket was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @lesson_ticket.destroy
    respond_to do |format|
      format.html { redirect_to lesson_tickets_url, notice: 'Lesson ticket was successfully destroyed.' }
    end
  end

  private
  def set_lesson_ticket
    @lesson_ticket = LessonTicket.find(params[:id])
  end
end
