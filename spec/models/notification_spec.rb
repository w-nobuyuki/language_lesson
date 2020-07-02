require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:lesson_reservation){ create(:teacher_english_lesson_reservation) }
  it 'はlesson_reservationとbodyがあれば有効であること' do
    notification = Notification.new(lesson_reservation: lesson_reservation, body: 'フィードバック内容です')
    expect(notification).to be_valid
  end
  it 'はlesson_reservationがなければ無効であること' do
    notification = Notification.new(lesson_reservation: nil)
    notification.valid?
    expect(notification.errors[:lesson_reservation]).to include('を入力してください')
  end
  it 'はbodyがなければ無効であること' do
    notification = Notification.new(body: nil)
    notification.valid?
    expect(notification.errors[:body]).to include('を入力してください')
  end
  it 'はbodyが300文字を超える場合無効であること' do
    notification = Notification.new(body: Faker::Lorem.characters(number: 301))
    notification.valid?
    expect(notification.errors[:body]).to include('は300文字以内で入力してください')
  end
  it 'はbodyが300文字なら有効であること' do
    notification = Notification.new(body: Faker::Lorem.characters(number: 300))
    notification.valid?
    expect(notification.errors[:body]).to eq []
  end
end
