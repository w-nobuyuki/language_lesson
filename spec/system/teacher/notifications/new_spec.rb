require 'rails_helper'

RSpec.describe 'Teacher::Notifications#new', type: :system do
  let!(:user) { create(:user) }
  let!(:teacher) { create(:teacher) }
  let!(:lesson) { create(:teacher_english_lesson, teacher: teacher) }
  let!(:lesson_reservation) { create(:teacher_english_lesson_reservation, user: user, lesson: lesson) }

  before do
    lesson.start_at = Date.yesterday.strftime('%Y/%m/%d 12:00')
    lesson.save!(validate: false)
    sign_in_teacher(teacher)
    visit new_teacher_lesson_reservation_notification_path(lesson_reservation)
  end

  it '内容を入力し登録するをクリックすると申し送りが登録されること' do
    fill_in 'notification[body]', with: '申し送りです'
    click_button '登録する'
    expect(page).to have_content '申し送り事項を登録しました。'
  end

  it '内容が空だと登録できないこと' do
    click_button '登録する'
    expect(page).to have_content '内容を入力してください'
  end

  it '内容が300文字を超えると登録できないこと' do
    fill_in 'notification[body]', with: Faker::Lorem.characters(number: 301)
    click_button '登録する'
    expect(page).to have_content '内容は300文字以内で入力してください'
  end

  it '戻るをクリックすると予約済みレッスン画面へ画面遷移すること' do
    click_link '戻る'
    expect(current_path).to eq teacher_lesson_reservation_notifications_path(lesson_reservation)
  end
end