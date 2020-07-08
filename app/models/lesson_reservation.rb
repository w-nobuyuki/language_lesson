class LessonReservation < ApplicationRecord
  belongs_to :lesson
  belongs_to :lesson_ticket
  # has_one :user, through: :lesson_ticket にすると lesson_reservations.includes(:user) できそう？
  delegate :user, to: :lesson_ticket
  # lesson に関連付けるのが自然では？
  has_many :feedbacks, dependent: :restrict_with_exception
  # lesson に関連付けるのが自然では？
  has_many :notifications, dependent: :restrict_with_exception

  validates :zoom_url, presence: true
  validate :cannot_reserve_same_datetime
  validate :cannot_reserve_same_lesson_ticket

  scope :only_completed, -> { joins(:lesson).where('lessons.start_at < ?', Time.current)}

  def cannot_reserve_same_datetime
    return if lesson_ticket.blank? || lesson.blank?

    LessonReservation.where(id: user.lesson_reservations.ids).each do |reservation|
      next if reservation.lesson.start_at != lesson.start_at

      errors.add(:base, 'その日時は他のレッスンを予約済みです')
      break
    end
  end

  def cannot_reserve_same_lesson_ticket
    return if lesson_ticket.blank?
    # lesson_ticket.used?
    return unless LessonReservation.find_by(lesson_ticket: lesson_ticket)

    errors.add(:lesson_ticket, 'は使用済みです。予約はキャンセルされました。')
  end

  def assign_zoom_url
    zoom_client = new_zoom_client
    meeting_room = zoom_client.meeting_create(
      user_id: Rails.application.credentials.zoom[:host_id],
      start_time: lesson.start_at,
      duration: 50,
      timezone: 'Asia/Tokyo',
      password: SecureRandom.alphanumeric(10),
      settings: {
        host_video: true,
        participant_video: true,
        cn_meeting: false,
        in_meeting: false,
        join_before_host: true,
        mute_upon_entry: false,
        waiting_room: false
      }
    )
    self.zoom_url = meeting_room['join_url']
  end

  def new_zoom_client
    Zoom.new
  end
end
