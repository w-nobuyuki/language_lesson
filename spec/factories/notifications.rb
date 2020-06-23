FactoryBot.define do
  factory :notification do
    lesson_reservation { nil }
    body { "MyText" }
  end
end
