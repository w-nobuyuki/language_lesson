FactoryBot.define do
  factory :charge do
    association :user
    association :item
    stripe_session_id { 'stripe-session-id' }
  end
end
