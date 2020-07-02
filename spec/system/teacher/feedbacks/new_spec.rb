require 'rails_helper'

RSpec.describe 'Teacher::Feedbacks#new', type: :system do
  let!(:user) { create(:user) }
  let!(:teacher) { create(:teacher) }
  let!(:lesson) { create(:teacher_english_lesson, teacher: teacher) }
  let!(:lesson_reservation) { create(:teacher_english_lesson_reservation, user: user, lesson: lesson) }

  before do
    lesson.start_at = Date.yesterday.strftime('%Y/%m/%d 12:00')
    lesson.save!(validate: false)
    sign_in_teacher(teacher)
    visit new_teacher_lesson_reservation_feedback_path(lesson_reservation)
  end

  it '内容を入力し登録するをクリックするとフィードバックが登録されること' do
    fill_in 'feedback[body]', with: 'フィードバックです'
    click_button '登録する'
    expect(page).to have_content 'フィードバックを登録しました。'
  end

  it '内容が空だと登録できないこと' do
    click_button '登録する'
    expect(page).to have_content '内容を入力してください'
  end

  it '内容が300文字を超えると登録できないこと' do
    fill_in 'feedback[body]', with: Faker::Lorem.characters(number: 301)
    click_button '登録する'
    expect(page).to have_content '内容は300文字以内で入力してください'
  end

  it '戻るをクリックすると予約済みレッスン画面へ画面遷移すること' do
    click_link '戻る'
    expect(current_path).to eq teacher_lesson_reservation_feedbacks_path(lesson_reservation)
  end
end