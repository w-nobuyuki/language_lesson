FactoryBot.define do
  factory :charge do
    association :user
    association :item, factory: :item_1
    stripe_session_id { 'stripe-session-id' }
  end
end
