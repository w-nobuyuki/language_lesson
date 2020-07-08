require 'rails_helper'

Rails.describe FeedbackMailer, type: :mailer do
  describe 'new_feedback' do
    # リテラル
    let(:feedback) { create(:teacher_english_lesson_feedback, body: 'よかったです') }
    # deliver_now する必要なさそう
    let(:mail) { FeedbackMailer.new_feedback(feedback).deliver_now }

    it 'は件名が「【tryout】レッスンのフィードバックが登録されました」であること' do
      expect(mail.subject).to eq '【tryout】レッスンのフィードバックが登録されました'
    end

    it 'は宛先がレッスンを受講したユーザーであること' do
      expect(mail.to).to include feedback.lesson_reservation.user.email
    end

    it 'は本文にフィードバックの内容が含まれること' do
      # 期待値はあえてのリテラル
      expect(mail.body.encoded).to match 'よかったです'
    end

    it 'は本文に担当講師名が含まれること' do
      expect(mail.body.encoded).to match feedback.lesson_reservation.lesson.teacher.name
    end

    it 'は本文に受講日時が含まれること' do
      expect(mail.body.encoded).to match lesson_datetime(feedback.lesson_reservation.lesson)
    end

    it 'は本文にレッスンの言語が含まれること' do
      expect(mail.body.encoded).to match feedback.lesson_reservation.lesson.language.name
    end
  end
end
