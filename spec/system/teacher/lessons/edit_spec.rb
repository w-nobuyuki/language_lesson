require 'rails_helper'

RSpec.describe 'Teacher::Lessons#edit', type: :system do
  let!(:teacher) { create(:teacher) }
  let!(:english) { create(:english) }
  let!(:lesson) { create(:teacher_english_lesson, language: english, teacher: teacher) }
  let!(:supported_english) { create(:teacher_supported_english, teacher: teacher, language: english) }
  let!(:supported_chinese) { create(:teacher_supported_chinese, teacher: teacher) }

  before do
    @start_at = Time.new(Date.tomorrow.year, Date.tomorrow.month, Date.tomorrow.day, 12)
    visit new_teacher_session_path
    fill_in 'teacher[email]',	with: 'teacher@tryout.com'
    fill_in 'teacher[password]',	with: 'password'
    click_button 'ログイン'
    visit edit_teacher_lesson_path(lesson)
  end

  it '更新完了後、更新完了メッセージが表示されること' do
    click_button '更新する'
    expect(page).to have_content 'レッスン枠を更新しました。'
  end

  it '言語の変更後、その変更が反映されること' do
    select('中国語', from: 'lesson[language_id]')
    click_button '更新する'
    within 'tbody' do
      tds = all('td').map(&:text)
      expect(tds[0]).to eq '中国語'
    end
  end

  it '言語が空の場合更新できないこと' do
    select('', from: 'lesson[language_id]')
    click_button '更新する'
    expect(page).to have_content '言語を入力してください'
  end

  it '言語はLanguageテーブルのデータから選択可能であること' do
    languages = all('option').map(&:text)
    expect(languages).to eq ['', '英語', '中国語']
  end

  it '開始日時の変更後、その変更が反映されること' do
    start_at = Time.new(Date.tomorrow.year, Date.tomorrow.month, Date.tomorrow.day, 20)
    fill_in 'lesson[start_at]', with: start_at
    click_button '更新する'
    within 'tbody' do
      tds = all('td').map(&:text)
      expect(tds[1]).to eq "#{start_at.strftime('%Y/%m/%d %H:%M')}～#{(start_at + 50.minutes).strftime('%H:%M')}"
    end
  end

  it '開始日時が空の場合更新できないこと' do
    fill_in 'lesson[start_at]', with: ''
    click_button '更新する'
    expect(page).to have_content '開始日時を入力してください'
  end

  it '開始日時は7:00 ～ 22:00の範囲外は更新できないこと' do
    start_at = Time.new(Date.tomorrow.year, Date.tomorrow.month, Date.tomorrow.day, 23)
    fill_in 'lesson[start_at]', with: start_at
    click_button '更新する'
    expect(page).to have_content '開始日時は不正な値です'
  end

  it '開始日時の時間は分、秒の単位が00:00のみ更新できること' do
    start_at = Time.new(Date.tomorrow.year, Date.tomorrow.month, Date.tomorrow.day, 12, 1, 1)
    fill_in 'lesson[start_at]', with: start_at
    click_button '更新する'
    expect(page).to have_content '開始日時は不正な値です'
  end

  it '開始日時は過去の日時は更新できないこと' do
    start_at = Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 12)
    fill_in 'lesson[start_at]', with: start_at
    click_button '更新する'
    expect(page).to have_content '開始日時は過去の日付は入力できません'
  end

  it '戻るボタンを押すとレッスン枠一覧画面に戻ること' do
    click_link '戻る'
    expect(current_path).to eq teacher_lessons_path
  end
end