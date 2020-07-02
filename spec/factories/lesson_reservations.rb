FactoryBot.define do
  factory :teacher_english_lesson_reservation, class: LessonReservation do
    association :lesson, factory: :teacher_english_lesson
    association :user
    zoom_url { 'https://zoom.co.jp' }
  end
end
