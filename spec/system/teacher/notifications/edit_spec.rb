require 'rails_helper'

RSpec.describe 'Teacher::Notifications#edit', type: :system do
  let!(:user) { create(:user) }
  let!(:teacher) { create(:teacher) }
  let!(:lesson) { create(:teacher_english_lesson, teacher: teacher) }
  let!(:lesson_ticket) { create(:lesson_ticket, user: user) }
  let!(:lesson_reservation) { create(:teacher_english_lesson_reservation, lesson: lesson, lesson_ticket: lesson_ticket) }
  let!(:notification) { create(:teacher_english_lesson_notification, lesson_reservation: lesson_reservation) }

  before do
    lesson.start_at = Date.yesterday.strftime('%Y/%m/%d 12:00')
    lesson.save!(validate: false)
    sign_in_teacher(teacher)
    visit edit_teacher_lesson_reservation_notification_path(lesson_reservation, notification)
  end

  it '更新するをクリックすると申し送りが更新されること' do
    click_button '更新する'
    expect(page).to have_content '申し送り事項を更新しました。'
  end

  it '内容を変更し更新するをクリックすると変更した内容が反映されていること' do
    fill_in 'notification[body]', with: '変更後の申し送り'
    click_button '更新する'
    within 'tbody' do
      tds = all('td').map(&:text)
      expect(tds[0]).to eq '変更後の申し送り'
    end
  end

  it '内容が空だと更新できないこと' do
    fill_in 'notification[body]', with: ''
    click_button '更新する'
    expect(page).to have_content '内容を入力してください'
  end

  it '内容が300文字を超えると更新できないこと' do
    fill_in 'notification[body]', with: Faker::Lorem.characters(number: 301)
    click_button '更新する'
    expect(page).to have_content '内容は300文字以内で入力してください'
  end

  it '戻るをクリックすると予約済みレッスン画面へ画面遷移すること' do
    click_link '戻る'
    expect(current_path).to eq teacher_lesson_reservation_notifications_path(lesson_reservation)
  end
end