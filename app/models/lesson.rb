class Lesson < ApplicationRecord
  belongs_to :teacher
  belongs_to :language
  has_one :lesson_reservation
  has_one :user, through: :lesson_reservation

  validates :start_at,
            presence: true,
            uniqueness: { scope: :teacher },
            format: { with: /\A*(0[7-9]|1[0-9]|2[0-2]):00:00 \+0900\z/, allow_blank: true }

  validate :cannot_past_datetime

  def end_at
    start_at + 3000
  end

  def cannot_past_datetime
    return if start_at.blank?

    errors.add(:start_at, 'は過去の日付は入力できません') if start_at < Time.now
  end
end
