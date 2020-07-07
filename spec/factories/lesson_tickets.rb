FactoryBot.define do
  factory :lesson_ticket do
    association :user
  end

  factory :user2_lesson_ticket, class: LessonTicket do
    association :user, factory: :user2
  end
end
