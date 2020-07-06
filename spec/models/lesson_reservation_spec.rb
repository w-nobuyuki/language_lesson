require 'rails_helper'

RSpec.describe LessonReservation, type: :model do
  let!(:lesson) { create(:teacher_english_lesson) }
  let!(:user) { create(:user) }
  let!(:lesson_ticket) { create(:lesson_ticket, user: user) }

  it 'はレッスン、レッスンチケット、zoom URLが存在すれば登録できること' do
    lesson_reservation = LessonReservation.new(lesson_ticket: lesson_ticket, lesson: lesson, zoom_url: 'https://zoom.co.jp')
    expect(lesson_reservation).to be_valid
  end

  it 'はレッスンが存在しなければ登録できないこと' do
    lesson_reservation = LessonReservation.new(lesson: nil)
    lesson_reservation.valid?
    expect(lesson_reservation.errors[:lesson]).to include('を入力してください')
  end

  it 'はレッスンチケットが存在しなければ登録できないこと' do
    lesson_reservation = LessonReservation.new(lesson_ticket: nil)
    lesson_reservation.valid?
    expect(lesson_reservation.errors[:lesson_ticket]).to include('を入力してください')
  end

  it 'はzoom urlが存在しなければ登録できないこと' do
    lesson_reservation = LessonReservation.new(zoom_url: nil)
    lesson_reservation.valid?
    expect(lesson_reservation.errors[:zoom_url]).to include('を入力してください')
  end

  it 'は同じユーザーが同じ時間のレッスンを予約できないこと' do
    LessonReservation.create(lesson_ticket: lesson_ticket, lesson: lesson, zoom_url: 'https://zoom.co.jp')
    lesson2 = create(:teacher2_english_lesson)
    lesson_ticket2 = user.lesson_tickets.create
    lesson_reservation = LessonReservation.new(lesson_ticket: lesson_ticket2, lesson: lesson2)
    lesson_reservation.valid?
    expect(lesson_reservation.errors[:base]).to include('その日時は他のレッスンを予約済みです')
  end

  it 'は同じレッスンチケットで複数の予約ができないこと' do
    LessonReservation.create(lesson_ticket: lesson_ticket, lesson: lesson, zoom_url: 'https://zoom.co.jp')
    lesson_reservation = LessonReservation.new(lesson_ticket: lesson_ticket)
    lesson_reservation.valid?
    expect(lesson_reservation.errors[:lesson_ticket]).to include('は使用済みです。予約はキャンセルされました。')
  end

end
