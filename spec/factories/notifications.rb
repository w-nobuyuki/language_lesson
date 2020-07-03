FactoryBot.define do
  factory :teacher_english_lesson_notification, class: Notification do
    association :lesson_reservation, factory: :teacher_english_lesson_reservation
    body { "フィードバック内容です" }
  end
end
