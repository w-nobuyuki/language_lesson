require 'rails_helper'

RSpec.describe Charge, type: :model do
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  it 'はユーザー、商品、StripeセッションIDが存在すれば登録できること' do
    charge = Charge.new(user: user, item: item, stripe_session_id: 'stripe-session-id')
    expect(charge).to be_valid
  end
  it 'はユーザーが存在しなければ登録できないこと' do
    charge = Charge.new(user: nil)
    charge.valid?
    expect(charge.errors[:user]).to include('を入力してください')
  end
  it 'は商品が存在しなければ登録できないこと' do
    charge = Charge.new(item: nil)
    charge.valid?
    expect(charge.errors[:item]).to include('を入力してください')
  end
  it 'はStripeセッションIDが存在しなければ登録できないこと' do
    charge = Charge.new(stripe_session_id: nil)
    charge.valid?
    expect(charge.errors[:stripe_session_id]).to include('を入力してください')
  end
  it 'はStripeセッションIDが重複している場合登録できないこと' do
    create(:charge)
    charge = build(:charge)
    charge.valid?
    expect(charge.errors[:stripe_session_id]).to include('はすでに存在します')
  end
end
