class ApplicationMailer < ActionMailer::Base
  default from: 'info@tryout.com'
  layout 'mailer'
  add_template_helper(LessonHelper)
end
