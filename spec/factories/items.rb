FactoryBot.define do
  factory :item do
    name { "レッスンチケット" }
    description { "レッスンチケットの購入券です" }
    amount { 2160 }
    quantity { 1 }
  end
end
