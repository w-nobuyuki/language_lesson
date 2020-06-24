class LessonReservation < ApplicationRecord
  belongs_to :lesson
  belongs_to :user
  # dependent: hogehoge
  has_many :feedbacks
  has_many :notifications

  validates :zoom_url, presence: true
  validate :cannot_reserve_same_datetime

  # Time.now -> Time.current
  scope :only_completed, -> { joins(:lesson).where('lessons.start_at < ?', Time.now) }

  def do_reserve
    transaction do
      raise ActiveRecord::Rollback unless save
      raise ActiveRecord::Rollback unless new_zoom_room
      user.lesson_tickets.first.destroy! # first でいいの？destroy でいいの？
      # Ticket と LessonReservation をなんらかの形で関連付けることで、Ticket の消化状況を測れると、履歴としても残すことができる

      true
    end
  end

  def self.new_with_zoom_url(*args)
    lesson_reservation = new(*args)
    zoom_client = Zoom.new
    meeting_room = zoom_client.meeting_create(
      user_id: Rails.application.credentials.zoom[:host_id],
      start_time: lesson_reservation.lesson.start_at,
      duration: 50,
      timezone: 'Asia/Tokyo',
      # faker はプロダクションコードではあまり使わない、rails 組み込みのコードで代替可能
      password: Faker::Lorem.characters(number: 6),
      # password: generate_unique_secure_token,
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
