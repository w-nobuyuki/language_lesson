require 'rails_helper'

RSpec.describe User, type: :model do
  it 'はemail, name, passwordが存在すればアカウントを登録できること' do
    user = User.new(email: 'test@sample.co.jp', name: 'user', password: 'password')
    expect(user).to be_valid
  end
  it 'はemailが存在しなければ登録できないこと' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end
  it 'はnameが存在しなければ登録できないこと' do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
  end
  it 'はnameが最大20文字まで入力できること' do
    user = User.new(name: Faker::Lorem.characters(number: 20))
    user.valid?
    expect(user.errors[:name]).to eq []
  end
  it 'はnameが20文字を超えると登録できないこと' do
    user = User.new(name: Faker::Lorem.characters(number: 21))
    user.valid?
    expect(user.errors[:name]).to include('は20文字以内で入力してください')
  end
  it 'はpasswordが存在しなければ登録できないこと' do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include('を入力してください')
  end
end
