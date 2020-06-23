require 'rails_helper'

RSpec.describe LessonTicket, type: :model do
  let(:user){ create(:user) }
  it 'はuserが存在すれば登録できること' do
    lesson_ticket = LessonTicket.new(user: user)
    expect(lesson_ticket).to be_valid
  end
  it 'はuserが存在しなければ登録できないこと' do
    lesson_ticket = LessonTicket.new(user: nil)
    lesson_ticket.valid?
    expect(lesson_ticket.errors[:user]).to include('を入力してください')
  end
end
