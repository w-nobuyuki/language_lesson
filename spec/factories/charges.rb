FactoryBot.define do
  factory :charge do
    # user # これで勝手に作ってくれる
    association :user
    association :item, factory: :item_1
    stripe_session_id { 'stripe-session-id' }
  end
end
