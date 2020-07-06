require 'rails_helper'

RSpec.describe Lesson, type: :model do
  let(:teacher) { create(:teacher) }
  let(:language) { create(:english) }
  it 'は講師、言語、開始日時が存在すれば登録できること' do
    lesson = Lesson.new(teacher: teacher, language: language, start_at: '2100/01/01 12:00')
    expect(lesson).to be_valid
  end
  it 'は講師が存在しなければ登録できないこと' do
    lesson = Lesson.new(teacher: nil)
    lesson.valid?
    expect(lesson.errors[:teacher]).to include('を入力してください')
  end
  it 'は言語が存在しなければ登録できないこと' do
    lesson = Lesson.new(language: nil)
    lesson.valid?
    expect(lesson.errors[:language]).to include('を入力してください')
  end
  it 'は開始日時が存在しなければ登録できないこと' do
    lesson = Lesson.new(start_at: nil)
    lesson.valid?
    expect(lesson.errors[:start_at]).to include('を入力してください')
  end
  it 'は開始日時が現在日時より前の場合登録できないこと' do
    lesson = Lesson.new(start_at: '2020/1/1 12:00')
    lesson.valid?
    expect(lesson.errors[:start_at]).to include('は過去の日付は入力できません')
  end
  it 'は開始日時の時間帯が7時より早い場合登録できないこと' do
    lesson = Lesson.new(start_at: '2100/1/1 06:00')
    lesson.valid?
    expect(lesson.errors[:start_at]).to include('は7時～22時の間で入力してください')
  end
  it 'は開始日時の時間帯が7時の場合登録できること' do
    lesson = Lesson.new(start_at: '2100/1/1 07:00')
    lesson.valid?
    expect(lesson.errors[:start_at]).to eq []
  end
  it 'は開始日時の時間帯が22時より遅い場合登録できないこと' do
    lesson = Lesson.new(start_at: '2100/1/1 23:00')
    lesson.valid?
    expect(lesson.errors[:start_at]).to include('は7時～22時の間で入力してください')
  end
  it 'は開始日時の時間帯が22時の場合登録できること' do
    lesson = Lesson.new(start_at: '2100/1/1 22:00')
    lesson.valid?
    expect(lesson.errors[:start_at]).to eq []
  end
  it 'は開始日時の分の値が00以外の場合登録できないこと' do
    lesson = Lesson.new(start_at: '2100/1/1 07:10')
    lesson.valid?
    expect(lesson.errors[:start_at]).to include('は7時～22時の間で入力してください')
  end
  it 'は開始日時の秒の値が00以外の場合登録できないこと' do
    lesson = Lesson.new(start_at: '2100/1/1 07:00:10')
    lesson.valid?
    expect(lesson.errors[:start_at]).to include('は7時～22時の間で入力してください')
  end
  it 'は終了日時が開始日時の50分後であること' do
    lesson = Lesson.new(start_at: '2100/1/1 07:00')
    expect(lesson.end_at).to eq Time.parse('2100/1/1 07:50')
  end
end
