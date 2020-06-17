class LessonReservation < ApplicationRecord
  belongs_to :lesson
  belongs_to :user

  validates :zoom_url, presence: true
  validate :cannot_reserve_same_datetime

  def cannot_reserve_same_datetime
    LessonReservation.where(user_id: user_id).each do |reservation|
      next if reservation.lesson.start_at != lesson.start_at

      errors.add(:base, 'その日時は他のレッスンを予約済みです')
      break
    end
  end
end
