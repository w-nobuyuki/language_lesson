require 'rails_helper'

RSpec.describe SupportedLanguage, type: :model do
  let(:teacher) { create(:teacher) }
  let(:language) { create(:language) }
  it 'はteacherとlanguageが存在すれば登録できること' do
    supported_language = SupportedLanguage.new(teacher: teacher, language: language)
    expect(supported_language).to be_valid
  end
  it 'はteacherが存在しなければ登録できないこと' do
    supported_language = SupportedLanguage.new(teacher: nil)
    supported_language.valid?
    expect(supported_language.errors[:teacher]).to include('を入力してください')
  end
  it 'はlanguageが存在しなければ登録できないこと' do
    supported_language = SupportedLanguage.new(language: nil)
    supported_language.valid?
    expect(supported_language.errors[:language]).to include('を入力してください')
  end
end
