class LessonReservation < ApplicationRecord
  belongs_to :lesson
  belongs_to :user

  validates :zoom_url, presence: true
end
