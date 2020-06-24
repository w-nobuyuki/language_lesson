FactoryBot.define do
  factory :feedback do
    association :lesson_reservation
    body { "フィードバック内容です" }
  end
end
