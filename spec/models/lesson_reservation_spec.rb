require 'rails_helper'

RSpec.describe LessonReservation, type: :model do
  let(:lesson) { create(:lesson) }
  let(:user) { create(:user) }
  it 'はレッスン、ユーザー、zoom URLが存在すれば登録できること' do
    lesson_reservation = LessonReservation.new(user: user, lesson: lesson, zoom_url: 'https://zoom.co.jp')
    expect(lesson_reservation).to be_valid
  end
  it 'はレッスンが存在しなければ登録できないこと' do
    lesson_reservation = LessonReservation.new(lesson: nil)
    lesson_reservation.valid?
    expect(lesson_reservation.errors[:lesson]).to include('を入力してください')
  end
  it 'はユーザーが存在しなければ登録できないこと' do
    lesson_reservation = LessonReservation.new(user: nil)
    lesson_reservation.valid?
    expect(lesson_reservation.errors[:user]).to include('を入力してください')
  end
  it 'はzoom urlが存在しなければ登録できないこと' do
    lesson_reservation = LessonReservation.new(zoom_url: nil)
    lesson_reservation.valid?
    expect(lesson_reservation.errors[:zoom_url]).to include('を入力してください')
  end
  it 'は同じユーザーが同じ時間のレッスンを予約できないこと' do
    LessonReservation.create(user: user, lesson: lesson, zoom_url: 'https://zoom.co.jp')
    lesson2 = create(:lesson2)
    lesson_reservation = LessonReservation.new(user: user, lesson: lesson2)
    lesson_reservation.valid?
    expect(lesson_reservation.errors[:base]).to include('その日時は他のレッスンを予約済みです')
  end
end
