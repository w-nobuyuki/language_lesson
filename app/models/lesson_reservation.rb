class LessonReservation < ApplicationRecord
  belongs_to :lesson
  belongs_to :user

  validates :zoom_url, presence: true
  validate :cannot_reserve_same_datetime

  def self.new_with_zoom_url(*args)
    lesson_reservation = new(*args)
    zoom_client = Zoom.new
    meeting_room = zoom_client.meeting_create(
      user_id: Rails.application.credentials.zoom[:host_id],
      start_time: lesson_reservation.lesson.start_at,
      duration: 50,
      timezone: 'Asia/Tokyo',
      password: Faker::Lorem.characters(number: 6),
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
    lesson_reservation.zoom_url = meeting_room['join_url']
    lesson_reservation
  end

  def cannot_reserve_same_datetime
    LessonReservation.where(user_id: user_id).each do |reservation|
      next if reservation.lesson.start_at != lesson.start_at

      errors.add(:base, 'その日時は他のレッスンを予約済みです')
      break
    end
  end
end
