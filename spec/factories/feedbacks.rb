FactoryBot.define do
  factory :feedback do
    lesson_reservation { nil }
    body { "MyText" }
  end
end
