require 'rails_helper'

RSpec.describe 'Feedbacks#index', type: :system do
  let(:feedback) { create(:teacher_english_lesson_feedback) }

  before do
    sign_in_user(feedback.lesson_reservation.user)
    visit lesson_reservation_feedbacks_path(feedback.lesson_reservation)
  end

  it 'テーブルのヘッダーにフィードバック内容と日時が表示されていること' do
    within 'thead' do
      ths = all('th').map(&:text)
      expect(ths).to include('フィードバック内容', '日時')
    end
  end

  it 'テーブルのボディにフィードバック内容と日時が表示されていること' do
    within 'tbody' do
      tds = all('td').map(&:text)
      expect(tds).to include(feedback.body, feedback.created_at.strftime('%Y/%m/%d %H:%M:%S'))
    end
  end

  it '戻るボタンを押すと予約済みレッスン一覧画面に戻ること' do
    click_link '戻る'
    expect(current_path).to eq lesson_reservations_path
  end
end
