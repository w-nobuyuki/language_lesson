FactoryBot.define do
  factory :item_1, class: Item do
    name { "レッスンチケット（1枚）" }
    description { "レッスンチケット1枚のの購入券です" }
    amount { 2160 }
    quantity { 1 }
  end

  factory :item_3, class: Item do
    name { "レッスンチケット（3枚）" }
    description { "レッスンチケット3枚の購入券です" }
    amount { 5400 }
    quantity { 3 }
  end
end
