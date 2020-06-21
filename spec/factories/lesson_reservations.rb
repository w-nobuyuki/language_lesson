FactoryBot.define do
  factory :lesson_reservation do
    association :lesson
    association :user
    zoom_url { 'https://zoom.co.jp' }
  end
end
