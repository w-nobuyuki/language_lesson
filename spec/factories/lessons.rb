FactoryBot.define do
  factory :teacher_english_lesson, class: Lesson do
    association :teacher
    association :language, factory: :english
    start_at { Date.tomorrow.strftime('%Y/%m/%d 12:00') }
  end

  factory :teacher_chinese_lesson, class: Lesson do
    association :teacher
    association :language, factory: :chinese
    start_at { Date.tomorrow.strftime('%Y/%m/%d 13:00') }
  end

  factory :teacher2_english_lesson, class: Lesson do
    association :teacher, factory: :teacher2
    association :language, factory: :english
    start_at { Date.tomorrow.strftime('%Y/%m/%d 12:00') }
  end
end
