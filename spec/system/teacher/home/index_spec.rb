require 'rails_helper'

RSpec.describe 'Teacher::Home#index', type: :system do
  before do
    create(:teacher)
    visit new_teacher_session_path
    fill_in 'teacher[email]',	with: 'teacher@tryout.com'
    fill_in 'teacher[password]',	with: 'password'
    click_button 'ログイン'
  end

  it 'トップページの文言が表示されていること' do
    expect(page).to have_content '外国語レッスンの講師画面です'
  end

  it 'ヘッダーのタイトルをクリックすると講師のトップページに画面遷移すること' do
    click_link '外国語レッスン'
    expect(current_path).to eq teacher_root_path
  end

  it 'ヘッダーのレッスン枠をクリックするとレッスン枠一覧画面へ画面遷移すること' do
    click_link 'レッスン枠'
    expect(current_path).to eq teacher_lessons_path
  end

  it 'ヘッダーの予約済みレッスンをクリックすると予約済みレッスン一覧画面へ画面遷移すること' do
    click_link '予約済みレッスン'
    expect(current_path).to eq teacher_lesson_reservations_path
  end

  it 'メニューのプロフィール編集をクリックするとプロフィール編集画面へ画面遷移すること' do
    click_link 'メニュー'
    click_link 'プロフィール編集'
    expect(current_path).to eq edit_teacher_profile_path
  end

  it 'メニューのログアウトをクリックすると講師がログアウトすること' do
    click_link 'メニュー'
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
  end
end
