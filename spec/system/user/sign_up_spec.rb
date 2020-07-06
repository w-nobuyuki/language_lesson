require 'rails_helper'

RSpec.describe 'User#sign_up', type: :system do
  before do
    visit new_user_registration_path
    fill_in 'user[email]', with: 'user@tryout.com'
    fill_in 'user[name]', with: 'user'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
  end

  it 'メールアドレス、ユーザー名、パスワード、パスワード確認を入力し登録するボタンを押すとログインできること' do
    click_button '登録する'
    expect(current_path).to eq root_path
  end

  it 'メールアドレスが空の場合アカウント登録に失敗すること' do
    fill_in 'user[email]', with: ''
    click_button '登録する'
    expect(page).to have_content 'メールアドレスを入力してください'
  end

  it 'ユーザー名が空の場合アカウント登録に失敗すること' do
    fill_in 'user[name]', with: ''
    click_button '登録する'
    expect(page).to have_content 'ユーザー名を入力してください'
  end

  it 'ユーザー名が20文字を超える場合アカウント登録に失敗すること' do
    fill_in 'user[name]', with: Faker::Lorem.characters(number: 21)
    click_button '登録する'
    expect(page).to have_content 'ユーザー名は20文字以内で入力してください'
  end

  it 'パスワードが空の場合アカウント登録に失敗すること' do
    fill_in 'user[password]', with: ''
    click_button '登録する'
    expect(page).to have_content 'パスワードを入力してください'
  end

  it 'パスワードとパスワード確認が一致しない場合アカウント登録に失敗すること' do
    fill_in 'user[password_confirmation]', with: 'password2'
    click_button '登録する'
    expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
  end

  it 'ログイン画面へ戻るリンクが存在すること' do
    expect(page).to have_link 'ログイン画面へ戻る'
  end

  it 'ログイン画面へ戻るリンクを押すとログイン画面へ画面遷移すること' do
    click_link 'ログイン画面へ戻る'
    expect(current_path).to eq new_user_session_path
  end
end