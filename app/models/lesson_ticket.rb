class LessonTicket < ApplicationRecord
  belongs_to :charge, optional: true
  belongs_to :user
end
