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
end