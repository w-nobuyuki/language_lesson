class FeedbackMailer < ApplicationMailer
  def new_feedback(feedback)
    @feedback = feedback
    mail to: feedback.lesson_reservation.user.email, subject: '【tryout】レッスンのフィードバックが登録されました'
  end
end
