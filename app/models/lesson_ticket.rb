class LessonTicket < ApplicationRecord
  belongs_to :charge, optional: true
  belongs_to :user
  has_one :lesson_reservation, dependent: :destroy

  scope :not_used, -> { includes(:lesson_reservation).where(lesson_reservations: { id: nil }) }
end
