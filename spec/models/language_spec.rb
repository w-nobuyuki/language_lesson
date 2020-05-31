require 'rails_helper'

RSpec.describe Language, type: :model do
  it 'はnameが存在すれば登録できること' do
    language = Language.new(name: '日本語')
    expect(language).to be_valid
  end

  it 'はnameの長さが20文字を超えると登録できないこと' do
    language = Language.new(name: Faker::Lorem.characters(number: 21))
    language.valid?
    expect(language.errors[:name]).to include 'は20文字以内で入力してください'
  end
end
