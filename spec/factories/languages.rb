FactoryBot.define do
  factory :english, class: Language do
    name { '英語' }
  end

  factory :chinese, class: Language do
    name { '中国語' }
  end
end
