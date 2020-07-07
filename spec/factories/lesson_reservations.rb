FactoryBot.define do
  factory :teacher_english_lesson_reservation, class: LessonReservation do
    association :lesson, factory: :teacher_english_lesson
    association :lesson_ticket
    zoom_url { 'https://zoom.co.jp' }
  end

  factory :user2_teacher_chinese_lesson_reservation, class: LessonReservation do
    association :lesson, factory: :teacher_chinese_lesson
    association :lesson_ticket, factory: :user2_lesson_ticket
    zoom_url { 'https://zoom.co.jp' }
  end
end
