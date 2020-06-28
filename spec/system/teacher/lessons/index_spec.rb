require 'rails_helper'

RSpec.describe 'Teacher::Lessons#index', type: :system, js: true do
  let!(:teacher) { create(:teacher) }
  let!(:lesson){ create(:lesson) }
  before do
    visit new_teacher_session_path
    fill_in 'teacher[email]',	with: 'teacher@tryout.com'
    fill_in 'teacher[password]',	with: 'password'
    click_button 'ログイン'
    visit teacher_lessons_path
  end

  it 'レッスン枠登録画面へのリンクをクリックするとレッスン枠登録画面へ移動すること'
  it 'テーブルのヘッダーに言語と開始日時が存在すること'
  it ''

  it '講師登録画面へのリンクをクリックすると講師登録画面へ画面遷移すること' do
    click_link '講師登録'
    expect(current_path).to eq new_admin_teacher_path
  end

  it '編集画面へのリンクをクリックすると編集画面へ画面遷移すること' do
    click_link '編集'
    expect(current_path).to eq edit_admin_teacher_path(teacher)
  end

  it '代理ログインをクリックすると講師のトップページへ画面遷移すること' do
    click_link '代理ログイン'
    expect(page).to have_content '外国語レッスンの講師画面です'
  end

  it '削除をクリックするとその講師が削除されること' do
    accept_confirm do
      click_link '削除'
    end
    expect(page).to have_content '講師を削除しました。'
  end

  it '講師が実施済みのレッスンを持っている場合講師を削除できないこと' do
    lesson = create(:lesson, teacher: teacher)
    create(:lesson_reservation, lesson: lesson)
    visit admin_teachers_path
    expect(page).to have_button('削除', disabled: true)
  end

  it 'テーブルのヘッダに氏名とメールアドレスが存在すること' do
    within 'thead' do
      ths = all('th').map(&:text)
      expect(ths[0..1]).to eq %w[氏名 メールアドレス]
    end
  end

  it '講師の氏名とメールアドレスが表示されていること' do
    within 'tbody' do
      tds = all('td').map(&:text)
      expect(tds[0..1]).to eq %w[Teacher teacher@tryout.com]
    end
  end
end