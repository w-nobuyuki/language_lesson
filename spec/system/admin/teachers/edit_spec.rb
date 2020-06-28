require 'rails_helper'

RSpec.describe 'Admin::Teachers#edit', type: :system do
  let!(:admin) { create(:admin) }
  let!(:teacher) { create(:teacher) }
  before do
    visit new_admin_session_path
    fill_in 'admin[email]',	with: 'admin@tryout.com'
    fill_in 'admin[password]',	with: 'password'
    click_button 'ログイン'
    visit edit_admin_teacher_path(teacher)
  end

  it 'メールアドレス、ユーザー名、パスワード、パスワード確認を入力して更新するを押すと一覧画面に画面遷移すること' do
    click_button '更新する'
    expect(current_path).to eq admin_teachers_path
  end
  it 'メールアドレス、ユーザー名、パスワード、パスワード確認を入力して更新するを押すとその講師が登録されること' do
    click_button '更新する'
    within 'tbody' do
      tds = all('td').map(&:text)
      expect(tds[0..1]).to eq %w[teacher teacher@tryout.com]
    end
  end
  it 'メールアドレスが空だと更新できないこと' do
    fill_in 'teacher[email]', with: ''
    click_button '更新する'
    expect(page).to have_content 'メールアドレスを入力してください'
  end
  it '講師名が空だと更新できないこと' do
    fill_in 'teacher[name]', with: ''
    click_button '更新する'
    expect(page).to have_content '講師名を入力してください'
  end
  it 'パスワードが空だと更新できないこと' do
    fill_in 'teacher[password]', with: ''
    click_button '更新する'
    expect(page).to have_content 'パスワードを入力してください'
  end
  it 'パスワードとパスワード確認が一致しないと更新できないこと' do
    fill_in 'teacher[password]', with: 'password2'
    click_button '更新する'
    expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
  end
  it '戻るボタンをクリックすると講師一覧画面に戻れること' do
    click_link '戻る'
    expect(current_path).to eq admin_teachers_path
  end
end