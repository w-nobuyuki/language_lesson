require 'rails_helper'

RSpec.describe Feedback, type: :model do
  let(:lesson_reservation){ create(:lesson_reservation) }
  it 'はlesson_reservationとbodyがあれば有効であること' do
    feedback = Feedback.new(lesson_reservation: lesson_reservation, body: 'フィードバック内容です')
    expect(feedback).to be_valid
  end
  it 'はlesson_reservationがなければ無効であること' do
    feedback = Feedback.new(lesson_reservation: nil)
    feedback.valid?
    expect(feedback.errors[:lesson_reservation]).to include('を入力してください')
  end
  it 'はbodyがなければ無効であること' do
    feedback = Feedback.new(body: nil)
    feedback.valid?
    expect(feedback.errors[:body]).to include('を入力してください')
  end
  it 'はbodyが300文字を超える場合無効であること' do
    feedback = Feedback.new(body: Faker::Lorem.characters(number: 301))
    feedback.valid?
    expect(feedback.errors[:body]).to include('は300文字以内で入力してください')
  end
  it 'はbodyが300文字なら有効であること' do
    feedback = Feedback.new(body: Faker::Lorem.characters(number: 300))
    feedback.valid?
    expect(feedback.errors[:body]).to eq []
  end
end
