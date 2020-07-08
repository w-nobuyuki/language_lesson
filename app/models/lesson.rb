# lesson -> lesson_reservation -> lesson_ticket -> user

class Lesson < ApplicationRecord
  belongs_to :teacher
  belongs_to :language
  has_one :lesson_reservation, dependent: :restrict_with_exception
  has_one :lesson_ticket, through: :lesson_reservation
  has_one :user, through: :lesson_ticket

  validates :start_at,
            presence: true,
            uniqueness: { scope: :teacher }

  validate :cannot_past_datetime
  validate :start_at_only_7am_to_10pm

  scope :only_reservable, lambda {
    # 1.hours.since
    includes(:lesson_reservation).where(lesson_reservations: { id: nil }, start_at: Time.current.since(1.hours)..)
  }

  def end_at
    start_at.since(50.minutes)
  end

  def cannot_past_datetime
    return if start_at.blank?

    errors.add(:start_at, 'は過去の日付は入力できません') if start_at < Time.current
  end

  def start_at_only_7am_to_10pm
    return if start_at.blank?
    return if start_at.hour >= 7 && start_at.hour <= 22 && start_at.min == 0 && start_at.sec == 0

    errors.add(:start_at, 'は7時～22時の間で入力してください')
  end
end
