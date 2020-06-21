require 'rails_helper'

RSpec.describe LessonTicket, type: :model do
  let(:charge){ create(:charge) }
  it 'はchargeが存在すれば登録できること' do
    lesson_ticket = LessonTicket.new(charge: charge)
    expect(lesson_ticket).to be_valid
  end
  it 'はchargeが存在しなければ登録できないこと' do
    lesson_ticket = LessonTicket.new(charge: nil)
    lesson_ticket.valid?
    expect(lesson_ticket.errors[:charge]).to include('を入力してください')
  end
end
