require 'rails_helper'

RSpec.describe "Admins#sign_in", type: :system do
  let!(:admin) { create(:admin) }
  before do
    visit new_admin_session_path
  end

  it 'メールアドレスの入力フォームが存在すること' do
    expect(page.find_field('admin[email]').present?).to be_truthy
  end

  it 'パスワードの入力フォームが存在すること' do
    expect(page.find_field('admin[password]').present?).to be_truthy
  end

  it 'ログインボタンが存在すること' do
    expect(page).to have_button 'ログイン'
  end

  it 'メールアドレスとパスワードが空の状態でログインボタンを押すとログインに失敗すること' do
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
  end

  it '誤ったパスワードでのログインができないこと' do
    fill_in 'admin[email]',	with: 'admin@tryout.com'
    fill_in 'admin[password]',	with: 'invalid'
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
  end

  it '誤ったメールアドレスでのログインができないこと' do
    fill_in 'admin[email]',	with: 'admin2@tryout.com'
    fill_in 'admin[password]',	with: 'password'
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
  end

  it 'ログインに成功すると管理者のトップページに画面遷移すること' do
    fill_in 'admin[email]',	with: 'admin@tryout.com'
    fill_in 'admin[password]',	with: 'password'
    click_button 'ログイン'
    expect(current_path).to eq admin_root_path
  end
end