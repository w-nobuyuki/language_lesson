require 'rails_helper'

RSpec.describe Admin, type: :model do
  it 'はメールアドレスとパスワードが存在すれば登録できること' do
    admin = Admin.new(email: 'test@tryout.com', password: 'password')
    expect(admin).to be_valid
  end
  it 'はメールアドレスが存在しなければ登録できないこと' do
    admin = Admin.new(email: nil)
    admin.valid?
    expect(admin.errors[:email]).to include('を入力してください')
  end
  it 'はパスワードが存在しなければ登録できないこと' do
    admin = Admin.new(password: nil)
    admin.valid?
    expect(admin.errors[:password]).to include('を入力してください')
  end
end
