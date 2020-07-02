require 'rails_helper'

RSpec.describe 'Teacher::Lessons#index', type: :system, js: true do
  let!(:lesson){ create(:teacher_english_lesson) }
  before do
    visit new_teacher_session_path
    fill_in 'teacher[email]',	with: 'teacher@tryout.com'
    fill_in 'teacher[password]',	with: 'password'
    click_button 'ログイン'
    visit teacher_lessons_path
  end

  it 'レッスン枠登録画面へのリンクをクリックするとレッスン枠登録画面へ移動すること' do
    click_link 'レッスン枠登録'
    expect(current_path).to eq new_teacher_lesson_path
  end

  it 'テーブルのヘッダーに言語と開始日時が存在すること' do
    within 'thead' do
      ths = all('th').map(&:text)
      expect(ths[0..1]).to eq %w[言語 開始日時]
    end
  end

  it 'テーブルボディに言語と開始日時が表示されていること' do
    start_at = "#{lesson.start_at.strftime('%Y/%m/%d %H:%M')}～#{lesson.end_at.strftime('%H:%M')}"
    within 'tbody' do
      tds = all('td').map(&:text)
      expect(tds[0..1]).to eq [lesson.language.name, start_at]
    end
  end

  context 'レッスンが予約されていない場合' do
    it '編集画面へのリンクをクリックすると編集画面に画面遷移すること' do
      click_link '編集'
      expect(current_path).to eq edit_teacher_lesson_path(lesson)
    end
    it '削除をクリックするとそのレッスン枠が削除されること' do
      accept_confirm do
        click_link '削除'
      end
      expect(page).to have_content 'レッスン枠を削除しました。'
    end
  end

  context 'レッスンが予約済みの場合' do
    it 'レッスンを削除しようとするとエラー画面が表示されること' do
      create(:teacher_english_lesson_reservation, lesson: lesson)
      accept_confirm do
        click_link '削除'
      end
      expect(page).to have_content 'レッスン枠を削除しました。'
    end
    it 'レッスンには予約済みと表示されること' do
      create(:teacher_english_lesson_reservation, lesson: lesson)
      visit teacher_lessons_path
      expect(page).to have_content '予約済み'
    end
  end
end