require "rails_helper"

RSpec.describe LessonMailer, type: :mailer do
  describe 'notice_user' do
    let(:lesson_reservation) { create(:teacher_english_lesson_reservation) }
    let(:mail) { LessonMailer.notice_user(lesson_reservation.lesson).deliver_now }

    it 'は件名が「【tryout】レッスンの予約が完了しました」であること' do
      expect(mail.subject).to eq '【tryout】レッスンの予約が完了しました'
    end

    it 'は宛先がユーザーであること' do
      expect(mail.to).to include lesson_reservation.user.email
    end

    it 'は本文に担当講師名が含まれること' do
      expect(mail.body.encoded).to match lesson_reservation.lesson.teacher.name
    end

    it 'は本文に予約時刻が含まれること' do
      expect(mail.body.encoded).to match lesson_datetime(lesson_reservation.lesson)
    end

    it 'は本文にzoom URLが含まれること' do
      expect(mail.body.encoded).to match lesson_reservation.zoom_url
    end
  end

  describe 'notice_teacher' do
    let(:lesson_reservation) { create(:teacher_english_lesson_reservation) }
    let(:mail) { LessonMailer.notice_teacher(lesson_reservation.lesson).deliver_now }

    it 'は件名が「【tryout】レッスンが予約されました」であること' do
      expect(mail.subject).to eq '【tryout】レッスンが予約されました'
    end

    it 'は宛先が講師であること' do
      expect(mail.to).to include lesson_reservation.lesson.teacher.email
    end

    it 'は本文に予約したユーザー名が含まれること' do
      expect(mail.body.encoded).to match lesson_reservation.user.name
    end

    it 'は本文に予約時刻が含まれること' do
      expect(mail.body.encoded).to match lesson_datetime(lesson_reservation.lesson)
    end

    it 'は本文にzoom URLが含まれること' do
      expect(mail.body.encoded).to match lesson_reservation.zoom_url
    end
  end
end
