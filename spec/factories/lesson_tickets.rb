FactoryBot.define do
  factory :lesson_ticket do
    association :charge
    association :user
  end
end
