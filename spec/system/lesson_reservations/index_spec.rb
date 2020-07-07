require 'rails_helper'

RSpec.describe 'Feedbacks#index', type: :system do
  let(:user) { create(:user) }
  let(:lesson_ticket) { create(:lesson_ticket, user: user) }
  let!(:lesson_reservation) { create(:teacher_english_lesson_reservation, lesson_ticket: lesson_ticket) }

  before do
    sign_in_user(user)
    visit lesson_reservations_path
  end

  it 'テーブルのヘッダーに講師、言語、日時、zoom URLが表示されていること' do
    within 'thead' do
      ths = all('th').map(&:text)
      expect(ths).to include('講師', '言語', '日時', 'zoom URL')
    end
  end

  it 'テーブルボディに講師名、言語、日時、zoom URLが表示されていること' do
    within 'tbody' do
      tds = all('td').map(&:text)
      expect(tds).to include(
        lesson_reservation.lesson.teacher.name,
        lesson_reservation.lesson.language.name,
        lesson_datetime(lesson_reservation.lesson),
        lesson_reservation.zoom_url
      )
    end
  end

  it '他のユーザーの予約済みレッスンが表示されないこと' do
    chinese_lesson = create(:teacher_chinese_lesson, teacher: lesson_reservation.lesson.teacher)
    create(:user2_teacher_chinese_lesson_reservation, lesson: chinese_lesson)
    visit lesson_reservations_path
    within 'tbody' do
      trs = all('tr')
      expect(trs.count).to eq 1
    end
  end

  context '講師からのフィードバックが存在する場合' do
    it 'フィードバック一覧画面へのリンクが表示されていること' do
      create(:teacher_english_lesson_feedback, lesson_reservation: lesson_reservation)
      lesson_reservation.lesson.start_at = Date.yesterday.strftime('%Y/%m/%d 12:00')
      lesson_reservation.lesson.save!(validate: false)
      visit lesson_reservations_path
      click_link 'フィードバック'
      expect(current_path).to eq lesson_reservation_feedbacks_path(lesson_reservation)
    end
  end
end