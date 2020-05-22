require 'rails_helper'

RSpec.describe Teacher, type: :model do
  it 'はemail, name, passwordが存在すればアカウントを登録できること' do
    teacher = Teacher.new(email: 'test@sample.co.jp', name: 'teacher', password: 'password')
    expect(teacher).to be_valid
  end
  it 'はemailが存在しなければ登録できないこと' do
    teacher = Teacher.new(email: nil)
    teacher.valid?
    expect(teacher.errors[:email]).to include('を入力してください')
  end
  it 'はnameが存在しなければ登録できないこと' do
    teacher = Teacher.new(name: nil)
    teacher.valid?
    expect(teacher.errors[:name]).to include('を入力してください')
  end
  it 'はnameが最大20文字まで入力できること' do
    teacher = Teacher.new(name: Faker::Lorem.characters(number: 20))
    teacher.valid?
    expect(teacher.errors[:name]).to eq []
  end
  it 'はnameが20文字を超えると登録できないこと' do
    teacher = Teacher.new(name: Faker::Lorem.characters(number: 21))
    teacher.valid?
    expect(teacher.errors[:name]).to include('は20文字以内で入力してください')
  end
  it 'はpasswordが存在しなければ登録できないこと' do
    teacher = Teacher.new(password: nil)
    teacher.valid?
    expect(teacher.errors[:password]).to include('を入力してください')
  end
end
