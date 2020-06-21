require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'は商品名、価格、数（チケット枚数）が存在すれば登録できること' do
    item = Item.new(name: 'レッスンチケット', amount: 2160, quantity: 1)
    expect(item).to be_valid
  end
  it 'は商品名がなければ登録できないこと' do
    item = Item.new(name: nil)
    item.valid?
    expect(item.errors[:name]).to include('を入力してください')
  end
  it 'は商品名は50文字を超えると登録できないこと' do
    item = Item.new(name: Faker::Lorem.characters(number: 51))
    item.valid?
    expect(item.errors[:name]).to include('は50文字以内で入力してください')
  end
  it 'は商品名は50文字の場合登録できること' do
    item = Item.new(name: Faker::Lorem.characters(number: 50))
    item.valid?
    expect(item.errors[:name]).to eq []
  end
  it 'は価格がなければ登録できないこと' do
    item = Item.new(amount: nil)
    item.valid?
    expect(item.errors[:amount]).to include('を入力してください')
  end
  it 'は価格が0未満の場合登録できないこと' do
    item = Item.new(amount: -1)
    item.valid?
    expect(item.errors[:amount]).to include('は0以上の値にしてください')
  end
  it 'は価格が0の場合登録できること' do
    item = Item.new(amount: 0)
    item.valid?
    expect(item.errors[:amount]).to eq []
  end
  it 'は数がなければ登録できないこと' do
    item = Item.new(quantity: nil)
    item.valid?
    expect(item.errors[:quantity]).to include('を入力してください')
  end
  it 'は数が0未満の場合登録できないこと' do
    item = Item.new(quantity: -1)
    item.valid?
    expect(item.errors[:quantity]).to include('は0以上の値にしてください')
  end
  it 'は数が0の場合登録できること' do
    item = Item.new(quantity: 0)
    item.valid?
    expect(item.errors[:quantity]).to eq []
  end
end
