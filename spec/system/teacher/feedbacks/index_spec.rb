require 'rails_helper'

RSpec.describe 'Teacher::Feedbacks#index', type: :system do
  let!(:user) { create(:user) }
  let!(:teacher) { create(:teacher) }
  let!(:lesson) { create(:teacher_english_lesson, teacher: teacher) }
  let!(:lesson_ticket) { create(:lesson_ticket, user: user) }
  let!(:lesson_reservation) { create(:teacher_english_lesson_reservation, lesson: lesson, lesson_ticket: lesson_ticket) }
  let!(:feedback) { create(:teacher_english_lesson_feedback, lesson_reservation: lesson_reservation) }

  before do
    lesson.start_at = Date.yesterday.strftime('%Y/%m/%d 12:00')
    lesson.save!(validate: false)
    sign_in_teacher(teacher)
    visit teacher_lesson_reservation_feedbacks_path(lesson_reservation)
  end

  it 'テーブルヘッダーに内容と登録日時が表示されていること' do
    within 'thead' do
      ths = all('th').map(&:text)
      expect(ths[0..1]).to eq %w[内容 登録日時]
    end
  end

  it 'テーブルボディにフィードバックの内容と登録日時が表示されていること' do
    within 'tbody' do
      tds = all('td').map(&:text)
      expect(tds[0..1]).to eq [feedback.body, feedback.created_at.strftime('%Y/%m/%d %H:%M:%S')]
    end
  end

  it '新規登録をクリックすると新規登録画面へ画面遷移すること' do
    click_link '新規登録'
    expect(current_path).to eq new_teacher_lesson_reservation_feedback_path(lesson_reservation)
  end

  it '編集をクリックすると編集画面へ画面遷移すること' do
    click_link '編集'
    expect(current_path).to eq edit_teacher_lesson_reservation_feedback_path(lesson_reservation, feedback)
  end

  it '削除をクリックするとフィードバックが削除されること' do
    accept_confirm do
      click_link '削除'
    end
    expect(page).to have_content '削除しました。'
  end

  it '戻るをクリックすると予約済みレッスン画面へ画面遷移すること' do
    click_link '戻る'
    expect(current_path).to eq teacher_lesson_reservations_path
  end
end