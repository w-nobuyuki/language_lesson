require 'rails_helper'

RSpec.describe 'Teacher::Home#edit', type: :system do
  let!(:teacher) { create(:teacher) }
  before do
    visit new_teacher_session_path
    fill_in 'teacher[email]',	with: 'teacher@tryout.com'
    fill_in 'teacher[password]',	with: 'password'
    click_button 'ログイン'
    visit teacher_edit_path
    fill_in 'teacher[current_password]', with: 'password'
  end

  it '現在のパスワードを入力し、更新するボタンをクリックすると講師のトップページに画面遷移すること' do
    click_button '更新する'
    expect(current_path).to eq teacher_root_path
  end

  it '現在のパスワードを入力しないと更新できないこと' do
    fill_in 'teacher[current_password]', with: ''
    click_button '更新する'
    expect(page).to have_content '現在のパスワードを入力してください'
  end

  it '講師名を変更し更新すると、その変更が反映されること' do
    fill_in 'teacher[name]', with: 'Teacher2'
    click_button '更新する'
    visit teacher_edit_path
    expect(page.find_field('teacher[name]').value).to eq 'Teacher2'
  end

  it 'プロフィールを変更し更新すると、その変更が反映されること' do
    fill_in 'teacher[profile]', with: '更新後のプロフィール'
    click_button '更新する'
    visit teacher_edit_path
    expect(page.find_field('teacher[profile]').value).to eq '更新後のプロフィール'
  end

  it 'アバターを変更し更新すると、その変更が反映されること' do
    rails_png = File.join(Rails.root, '/spec/resources/image.png')
    attach_file 'teacher[avatar]', rails_png
    click_button '更新する'
    visit teacher_edit_path
    expect(page.find('img')['src']).to match(/thumb_image.png/)
  end

  it '対応言語を変更し更新すると、その変更が反映されること' do
    create(:english)
    create(:chinese)
    visit teacher_edit_path
    select('英語', from: 'teacher[language_ids][]')
    select('中国語', from: 'teacher[language_ids][]')
    click_button '更新する'
    visit teacher_edit_path
    expect(page).to have_select('teacher[language_ids][]', selected: %w[英語 中国語])
  end

  it 'パスワードを変更し更新すると、その変更が反映されること' do
    fill_in 'teacher[password]', with: 'password2'
    fill_in 'teacher[password_confirmation]', with: 'password2'
    click_button '更新する'
    click_link 'メニュー'
    click_link 'ログアウト'
    fill_in 'teacher[email]',	with: 'teacher@tryout.com'
    fill_in 'teacher[password]',	with: 'password2'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
  end

  it 'パスワードとパスワード確認が一致していない場合パスワードは変更できないこと' do
    fill_in 'teacher[password]', with: 'password2'
    fill_in 'teacher[password_confirmation]', with: 'password3'
    click_button '更新する'
    expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
  end

  it '講師名が空の状態では更新できないこと' do
    fill_in 'teacher[name]', with: ''
    click_button '更新する'
    expect(page).to have_content '講師名を入力してください'
  end
end