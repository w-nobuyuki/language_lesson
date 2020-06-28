require 'rails_helper'

RSpec.describe 'Admin::Home#index', type: :system do
  before do
    create(:admin)
    visit new_admin_session_path
    fill_in 'admin[email]',	with: 'admin@tryout.com'
    fill_in 'admin[password]',	with: 'password'
    click_button 'ログイン'
  end
  it 'トップページの文言が表示されていること' do
    expect(page).to have_content '外国語レッスンの管理者用ページです。'
  end
  it 'ヘッダーのタイトルをクリックすると管理者のトップページに画面遷移すること' do
    click_link '外国語レッスン'
    expect(current_path).to eq admin_root_path
  end
  it 'メニューのログアウトをクリックすると管理者がログアウトすること' do
    click_link 'メニュー'
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
  end
end