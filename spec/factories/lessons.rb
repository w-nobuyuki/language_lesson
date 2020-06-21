FactoryBot.define do
  factory :lesson do
    association :teacher
    association :language
    start_at { Date.tomorrow.strftime('%Y/%m/%d 12:00') }
  end

  factory :lesson2, class: Lesson do
    association :teacher, factory: :teacher2
    association :language
    start_at { Date.tomorrow.strftime('%Y/%m/%d 12:00') }
  end
end
