require 'rails_helper'

RSpec.describe "Teachers#sign_in", type: :system do
  let!(:teacher) { create(:teacher) }
  before do
    visit new_teacher_session_path
  end

  it 'メールアドレスの入力フォームが存在すること' do
    expect(page.find_field('teacher[email]').present?).to be_truthy
  end

  it 'パスワードの入力フォームが存在すること' do
    expect(page.find_field('teacher[password]').present?).to be_truthy
  end

  it 'ログインボタンが存在すること' do
    expect(page).to have_button 'ログイン'
  end

  it 'メールアドレスとパスワードが空の状態でログインボタンを押すとログインに失敗すること' do
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
  end

  it '誤ったパスワードでのログインができないこと' do
    fill_in 'teacher[email]',	with: 'teacher@tryout.com'
    fill_in 'teacher[password]',	with: 'invalid'
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
  end

  it '誤ったメールアドレスでのログインができないこと' do
    fill_in 'teacher[email]',	with: 'teacher2@tryout.com'
    fill_in 'teacher[password]',	with: 'password'
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
  end

  it 'ログインに成功すると管理者のトップページに画面遷移すること' do
    fill_in 'teacher[email]',	with: 'teacher@tryout.com'
    fill_in 'teacher[password]',	with: 'password'
    click_button 'ログイン'
    expect(current_path).to eq teacher_root_path
  end
end