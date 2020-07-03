require 'rails_helper'

Rails.describe 'Home#index', type: :system do
  before do
    user = create(:user)
    sign_in_user(user)
    visit root_path
  end

  it 'トップページの文言が表示されていること' do
    expect(page).to have_content '外国語レッスンのユーザー画面です'
  end

  it 'ナビゲーションバーのタイトルをクリックするとユーザーのトップページに画面遷移すること' do
    click_link '外国語レッスン'
    expect(current_path).to eq root_path
  end

  it 'ナビゲーションバーのチケット購入をクリックするとチケット購入画面へ画面遷移すること' do
    click_link 'チケット購入'
    expect(current_path).to eq items_path
  end

  it 'ナビゲーションバーのレッスン予約をクリックするとレッスン一覧画面へ画面遷移すること' do
    click_link 'レッスン予約'
    expect(current_path).to eq lessons_path
  end

  it 'ナビゲーションバーの予約済みレッスン一覧をクリックすると予約済みレッスン一覧画面へ画面遷移すること' do
    click_link '予約済みレッスン一覧'
    expect(current_path).to eq lesson_reservations_path
  end

  it 'メニューのログアウトをクリックすると講師がログアウトすること' do
    click_link 'メニュー'
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
  end
end