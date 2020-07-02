FactoryBot.define do
  factory :teacher_english_lesson_feedback, class: Feedback do
    association :lesson_reservation, factory: :teacher_english_lesson_reservation
    body { "フィードバック内容です" }
  end
end
