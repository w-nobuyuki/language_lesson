require 'rails_helper'

RSpec.describe 'Teacher::LessonReservations#index', type: :system do
  let!(:user){ create(:user) }
  let!(:teacher){ create(:teacher) }
  let!(:lesson){ create(:teacher_english_lesson, teacher: teacher) }
  let!(:lesson_ticket) { create(:lesson_ticket, user: user) }
  let!(:lesson_reservation) { create(:teacher_english_lesson_reservation, lesson: lesson, lesson_ticket: lesson_ticket) }
  before do
    sign_in_teacher(teacher)
    visit teacher_lesson_reservations_path
  end

  it 'ユーザ名をクリックするとユーザーの受講履歴画面に画面遷移すること' do
    click_link 'user'
    expect(current_path).to eq teacher_user_path(user)
  end

  it 'テーブルのヘッダにユーザー名、日時、言語、zoom URLが存在すること' do
    within 'thead' do
      ths = all('th').map(&:text)
      expect(ths[0..3]).to eq ['ユーザー名', '日時', '言語', 'zoom URL']
    end
  end

  it 'テーブルボディにユーザー名、レッスン日時、言語、zoom URLが表示されていること' do
    within 'tbody' do
      tds = all('td').map(&:text)
      expect(tds[0..3]).to eq [user.name, lesson_datetime(lesson), lesson.language.name, lesson_reservation.zoom_url]
    end
  end

  context 'レッスンが終了前の場合' do
    it 'フィードバック画面へのリンクが表示されていないこと' do
      expect(page).to_not have_link 'フィードバック'
    end

    it '申し送り画面へのリンクが表示されていないこと' do
      expect(page).to_not have_link '申し送り'
    end
  end

  context 'レッスン終了後の場合' do
    before do
      lesson.start_at = Date.yesterday.strftime('%Y/%m/%d 12:00')
      lesson.save!(validate: false)
      visit teacher_lesson_reservations_path
    end

    it 'フィードバック画面へのリンクが表示されていること' do
      expect(page).to have_link 'フィードバック'
    end

    it '申し送り画面へのリンクが表示されていること' do
      expect(page).to have_link '申し送り'
    end

    it 'フィードバックをクリックするとフィードバック一覧画面へ画面遷移すること' do
      click_link 'フィードバック'
      expect(current_path).to eq teacher_lesson_reservation_feedbacks_path(lesson_reservation)
    end

    it '申し送りをクリックすると申し送り一覧画面へ画面遷移すること' do
      click_link '申し送り'
      expect(current_path).to eq teacher_lesson_reservation_notifications_path(lesson_reservation)
    end
  end
end