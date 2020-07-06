require 'rails_helper'

RSpec.describe 'Teacher::Lessons#new', type: :system do
  let!(:teacher) { create(:teacher) }
  let!(:supported_english) { create(:teacher_supported_english, teacher: teacher) }
  let!(:supported_chinese) { create(:teacher_supported_chinese, teacher: teacher) }
  before do
    @start_at = Time.new(Date.tomorrow.year, Date.tomorrow.month, Date.tomorrow.day, 12)
    visit new_teacher_session_path
    fill_in 'teacher[email]',	with: 'teacher@tryout.com'
    fill_in 'teacher[password]',	with: 'password'
    click_button 'ログイン'
    visit new_teacher_lesson_path
  end

  it '言語、開始日時を入力し登録するボタンを押すとレッスン枠が登録されること' do
    select('英語', from: 'lesson[language_id]')
    fill_in 'lesson[start_at]', with: @start_at
    click_button '登録する'
    within 'tbody' do
      tds = all('td').map(&:text)
      expect(tds).to include('英語', "#{@start_at.strftime('%Y/%m/%d %H:%M')}～#{(@start_at + 50.minutes).strftime('%H:%M')}")
    end
  end

  it 'レッスン枠登録後、登録完了メッセージが表示されること' do
    select('英語', from: 'lesson[language_id]')
    fill_in 'lesson[start_at]', with: @start_at
    click_button '登録する'
    expect(page).to have_content 'レッスン枠を登録しました。'
  end

  it '言語が空の場合登録できないこと' do
    fill_in 'lesson[start_at]', with: @start_at
    click_button '登録する'
    expect(page).to have_content '言語を入力してください'
  end

  it '言語はLanguageテーブルのデータから選択可能であること' do
    languages = all('option').map(&:text)
    expect(languages).to eq ['', '英語', '中国語']
  end

  it '開始日時が空の場合登録できないこと' do
    select('英語', from: 'lesson[language_id]')
    click_button '登録する'
    expect(page).to have_content '開始日時を入力してください'
  end

  it '開始日時は7:00 ～ 22:00の範囲外は登録できないこと' do
    start_at = Time.new(Date.tomorrow.year, Date.tomorrow.month, Date.tomorrow.day, 23)
    fill_in 'lesson[start_at]', with: start_at
    click_button '登録する'
    expect(page).to have_content '開始日時は7時～22時の間で入力してください'
  end

  it '開始日時の時間は分、秒の単位が00:00のみ登録できること' do
    start_at = Time.new(Date.tomorrow.year, Date.tomorrow.month, Date.tomorrow.day, 12, 1, 1)
    fill_in 'lesson[start_at]', with: start_at
    click_button '登録する'
    expect(page).to have_content '開始日時は7時～22時の間で入力してください'
  end

  it '開始日時は過去の日時は登録できないこと' do
    start_at = Time.new(Date.yesterday.year, Date.yesterday.month, Date.yesterday.day, 12)
    fill_in 'lesson[start_at]', with: start_at
    click_button '登録する'
    expect(page).to have_content '開始日時は過去の日付は入力できません'
  end

  it '戻るボタンを押すとレッスン枠一覧画面に戻ること' do
    click_link '戻る'
    expect(current_path).to eq teacher_lessons_path
  end
end