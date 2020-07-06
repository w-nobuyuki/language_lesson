require 'rails_helper'

RSpec.describe "User#sign_in", type: :system do
  let!(:user) { create(:user) }
  before do
    visit new_user_session_path
  end

  it 'メールアドレスの入力フォームが存在すること' do
    expect(page.find_field('user[email]').present?).to be_truthy
  end

  it 'パスワードの入力フォームが存在すること' do
    expect(page.find_field('user[password]').present?).to be_truthy
  end

  it 'ログインボタンが存在すること' do
    expect(page).to have_button 'ログイン'
  end

  it 'アカウント登録画面へのリンクが存在すること' do
    expect(page).to have_link 'アカウントを登録する'
  end

  it 'メールアドレスとパスワードが空の状態でログインボタンを押すとログインに失敗すること' do
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
  end

  it '誤ったパスワードでのログインができないこと' do
    fill_in 'user[email]',	with: 'user@tryout.com'
    fill_in 'user[password]',	with: 'invalid'
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
  end

  it '誤ったメールアドレスでのログインができないこと' do
    fill_in 'user[email]',	with: 'user2@tryout.com'
    fill_in 'user[password]',	with: 'password'
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
  end

  it 'ログインに成功すると管理者のトップページに画面遷移すること' do
    fill_in 'user[email]',	with: 'user@tryout.com'
    fill_in 'user[password]',	with: 'password'
    click_button 'ログイン'
    expect(current_path).to eq root_path
  end

  it 'アカウント登録画面へのリンクを押すとアカウント登録画面に画面遷移すること' do
    click_link 'アカウントを登録する'
    expect(current_path).to eq new_user_registration_path
  end
end