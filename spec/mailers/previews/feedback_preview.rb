# Preview all emails at http://localhost:3000/rails/mailers/feedback
class FeedbackPreview < ActionMailer::Preview
  def new_feedback
    feedback = Feedback.first
    FeedbackMailer.new_feedback(feedback)
  end
end
